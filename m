Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11B393D4E
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 08:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhE1GqY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 02:46:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48552 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhE1GqX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 02:46:23 -0400
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57E1D8C7;
        Fri, 28 May 2021 08:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622184287;
        bh=8iafTruYlTPcuzhTxWfAHVoehPZpu5bhMZEgahfJlLw=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=nfc7s4rHvEsaYjalxos3+r1ZPGBOc//BIv1gwkoDeTHXhKeWqd4SJTaI61gNeGaTz
         L85FBYKY7a5AHD3n8Pt98VNoK3I2qrnh1wZj2VgMPZPchGyliBWbK1psXZDxj/EpO9
         hHutshhHOrmO7U57OD6gQ2qfEBRMOB8ZteoDcaeg=
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-6-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 05/18] media: ov5640: Use runtime PM to control sensor
 power
Message-ID: <72352182-66ac-121e-ab09-da52af1b7581@ideasonboard.com>
Date:   Fri, 28 May 2021 09:44:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-6-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/05/2021 18:22, Pratyush Yadav wrote:
> Calling s_power subdev callback is discouraged. Instead, the subdevs
> should use runtime PM to control its power. Use runtime PM callbacks to
> control sensor power. The pm counter is incremented when the stream is
> started and decremented when the stream is stopped.
> 
> Refactor s_stream() a bit to make this new control flow easier. Add a
> helper to choose whether mipi or dvp set_stream needs to be called. The
> logic flow is also changed to make it a bit clearer.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - New in v2.
> 
>   drivers/media/i2c/Kconfig  |   2 +-
>   drivers/media/i2c/ov5640.c | 124 +++++++++++++++++++++++--------------
>   2 files changed, 77 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 462c0e059754..5588fc1cc14a 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -914,7 +914,7 @@ config VIDEO_OV2740
>   
>   config VIDEO_OV5640
>   	tristate "OmniVision OV5640 sensor support"
> -	depends on OF
> +	depends on OF && PM
>   	depends on GPIOLIB && VIDEO_V4L2 && I2C
>   	select MEDIA_CONTROLLER
>   	select VIDEO_V4L2_SUBDEV_API
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 5b9cc71df473..4ed5758e2398 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -15,6 +15,7 @@
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -238,8 +239,6 @@ struct ov5640_dev {
>   	/* lock to protect all members below */
>   	struct mutex lock;
>   
> -	int power_count;
> -
>   	struct v4l2_mbus_framefmt fmt;
>   	bool pending_fmt_change;
>   
> @@ -1277,6 +1276,14 @@ static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
>   				on ? 0x00 : 0x0f);
>   }
>   
> +static int ov5640_set_stream(struct ov5640_dev *sensor, bool on)
> +{
> +	if (sensor->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
> +		return ov5640_set_stream_mipi(sensor, on);
> +	else
> +		return ov5640_set_stream_dvp(sensor, on);
> +}
> +
>   static int ov5640_get_sysclk(struct ov5640_dev *sensor)
>   {
>   	 /* calculate sysclk */
> @@ -2155,37 +2162,6 @@ static int ov5640_set_power(struct ov5640_dev *sensor, bool on)
>   
>   /* --------------- Subdev Operations --------------- */
>   
> -static int ov5640_s_power(struct v4l2_subdev *sd, int on)
> -{
> -	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> -	int ret = 0;
> -
> -	mutex_lock(&sensor->lock);
> -
> -	/*
> -	 * If the power count is modified from 0 to != 0 or from != 0 to 0,
> -	 * update the power state.
> -	 */
> -	if (sensor->power_count == !on) {
> -		ret = ov5640_set_power(sensor, !!on);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	/* Update the power count. */
> -	sensor->power_count += on ? 1 : -1;
> -	WARN_ON(sensor->power_count < 0);
> -out:
> -	mutex_unlock(&sensor->lock);
> -
> -	if (on && !ret && sensor->power_count == 1) {
> -		/* restore controls */
> -		ret = v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
> -	}
> -
> -	return ret;
> -}
> -
>   static int ov5640_try_frame_interval(struct ov5640_dev *sensor,
>   				     struct v4l2_fract *fi,
>   				     u32 width, u32 height)
> @@ -2681,6 +2657,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
>   {
>   	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
>   	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +	struct device *dev = &sensor->i2c_client->dev;
>   	int ret;
>   
>   	/* v4l2_ctrl_lock() locks our own mutex */
> @@ -2690,7 +2667,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
>   	 * not apply any controls to H/W at this time. Instead
>   	 * the controls will be restored right after power-up.
>   	 */
> -	if (sensor->power_count == 0)
> +	if (pm_runtime_suspended(dev))
>   		return 0;
>   
>   	switch (ctrl->id) {
> @@ -2939,39 +2916,56 @@ static int ov5640_enum_mbus_code(struct v4l2_subdev *sd,
>   static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>   {
>   	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +	struct device *dev = &sensor->i2c_client->dev;
>   	int ret = 0;
>   
>   	mutex_lock(&sensor->lock);
>   
> -	if (sensor->streaming == !enable) {
> -		if (enable && sensor->pending_mode_change) {
> +	if (sensor->streaming == enable)
> +		goto out;
> +
> +	if (enable) {
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret < 0) {
> +			pm_runtime_put_noidle(dev);
> +			goto out;
> +		}

There now seems to be a function to do the above steps: 
pm_runtime_resume_and_get.

> +
> +		if (sensor->pending_mode_change) {
>   			ret = ov5640_set_mode(sensor);
>   			if (ret)
> -				goto out;
> +				goto put_pm;
>   		}
>   
> -		if (enable && sensor->pending_fmt_change) {
> +		if (sensor->pending_fmt_change) {
>   			ret = ov5640_set_framefmt(sensor, &sensor->fmt);
>   			if (ret)
> -				goto out;
> +				goto put_pm;
>   			sensor->pending_fmt_change = false;
>   		}
>   
> -		if (sensor->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
> -			ret = ov5640_set_stream_mipi(sensor, enable);
> -		else
> -			ret = ov5640_set_stream_dvp(sensor, enable);
> +		ret = ov5640_set_stream(sensor, enable);
> +		if (ret)
> +			goto put_pm;
> +	} else {
> +		ret = ov5640_set_stream(sensor, enable);

Instead of using "enable" here (and in the enable path above), just use 
true/false. It'll be more readable.

> +		if (ret)
> +			goto out;
>   
> -		if (!ret)
> -			sensor->streaming = enable;
> +		pm_runtime_put(dev);
>   	}
> +
> +	sensor->streaming = enable;
> +	goto out;
> +
> +put_pm:
> +	pm_runtime_put(dev);
>   out:
>   	mutex_unlock(&sensor->lock);
>   	return ret;
>   }

The flow in the above function is quite confusing. I think you should 
either 1) have a separate error paths via gotos and a return 0 before 
the error labels, or 2) common error and success path, without that 
final "goto out" you have above.

Maybe if you move the code in the "if (enable) {} else {}" to the 
ov5640_set_stream(), the flow will be easier to manage.

>   
>   static const struct v4l2_subdev_core_ops ov5640_core_ops = {
> -	.s_power = ov5640_s_power,
>   	.log_status = v4l2_ctrl_subdev_log_status,
>   	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
>   	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
> @@ -3037,6 +3031,29 @@ static int ov5640_check_chip_id(struct ov5640_dev *sensor)
>   	return ret;
>   }
>   
> +static int ov5640_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
> +	struct ov5640_dev *sensor = to_ov5640_dev(subdev);
> +
> +	return ov5640_set_power(sensor, false);
> +}
> +
> +static int ov5640_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
> +	struct ov5640_dev *sensor = to_ov5640_dev(subdev);
> +	int ret = 0;
> +
> +	ret = ov5640_set_power(sensor, true);
> +	if (ret)
> +		return ret;
> +
> +	return __v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
> +}
> +
>   static int ov5640_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> @@ -3162,13 +3179,17 @@ static int ov5640_probe(struct i2c_client *client)
>   	if (ret)
>   		goto entity_cleanup;
>   
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_suspended(dev);
> +
>   	ret = v4l2_async_register_subdev_sensor(&sensor->sd);
>   	if (ret)
> -		goto free_ctrls;
> +		goto error_pm;
>   
>   	return 0;
>   
> -free_ctrls:
> +error_pm:
> +	pm_runtime_disable(dev);

The label style used here seems to be the 
"label-tells-what-will-be-done", so I think instead of "error_pm", it 
should be, perhaps, "pm_disable".

>   	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
>   entity_cleanup:
>   	media_entity_cleanup(&sensor->sd.entity);
> @@ -3178,17 +3199,23 @@ static int ov5640_probe(struct i2c_client *client)
>   
>   static int ov5640_remove(struct i2c_client *client)
>   {
> +	struct device *dev = &client->dev;
>   	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>   	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>   
>   	v4l2_async_unregister_subdev(&sensor->sd);
>   	media_entity_cleanup(&sensor->sd.entity);
> +	pm_runtime_disable(dev);
>   	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
>   	mutex_destroy(&sensor->lock);
>   
>   	return 0;
>   }
>   
> +static const struct dev_pm_ops ov5640_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ov5640_suspend, ov5640_resume, NULL)
> +};
> +
>   static const struct i2c_device_id ov5640_id[] = {
>   	{"ov5640", 0},
>   	{},
> @@ -3205,6 +3232,7 @@ static struct i2c_driver ov5640_i2c_driver = {
>   	.driver = {
>   		.name  = "ov5640",
>   		.of_match_table	= ov5640_dt_ids,
> +		.pm = &ov5640_pm_ops,
>   	},
>   	.id_table = ov5640_id,
>   	.probe_new = ov5640_probe,
> 

