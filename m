Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D038926A57B
	for <lists+dmaengine@lfdr.de>; Tue, 15 Sep 2020 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOMqS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Sep 2020 08:46:18 -0400
Received: from foss.arm.com ([217.140.110.172]:34846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgIOMpx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Sep 2020 08:45:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F1C31FB;
        Tue, 15 Sep 2020 05:45:38 -0700 (PDT)
Received: from [10.57.18.138] (unknown [10.57.18.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211743F718;
        Tue, 15 Sep 2020 05:45:36 -0700 (PDT)
Subject: Re: 6b41030fdc790 broke dmatest badly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
 <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
 <20200907140502.GK1891694@smile.fi.intel.com>
 <54ba60c3-9a04-51ac-688c-425b85202b18@arm.com>
 <578f9c4d-3d29-d1f3-17f7-94dfe24403c4@arm.com>
 <20200915123537.GU3956970@smile.fi.intel.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d2d43434-d75a-a6cd-c6f9-daaa20260e58@arm.com>
Date:   Tue, 15 Sep 2020 13:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200915123537.GU3956970@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/15/20 1:35 PM, Andy Shevchenko wrote:
> On Fri, Sep 11, 2020 at 09:34:04AM +0100, Vladimir Murzin wrote:
>> On 9/7/20 5:52 PM, Vladimir Murzin wrote:
>>> On 9/7/20 3:05 PM, Andy Shevchenko wrote:
>>>> On Mon, Sep 07, 2020 at 02:06:23PM +0100, Vladimir Murzin wrote:
>>>>> On 9/7/20 1:06 PM, Andy Shevchenko wrote:
>>>>>> On Mon, Sep 07, 2020 at 12:03:26PM +0100, Vladimir Murzin wrote:
>>>>>>> On 9/4/20 6:34 PM, Andy Shevchenko wrote:
>>>>>>>> It becomes a bit annoying to fix dmatest after almost each release.
>>>>>>>> The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
>>>>>>>> broke my use case when I tried to start busy channel.
>>>>>>>>
>>>>>>>> So, before this patch
>>>>>>>> 	...
>>>>>>>> 	echo "busy_chan" > channel
>>>>>>>> 	echo 1 > run
>>>>>>>> 	sh: write error: Device or resource busy
>>>>>>>> 	[ 1013.868313] dmatest: Could not start test, no channels configured
>>>>>>>>
>>>>>>>> After I have got it run on *ALL* available channels.
>>>>>>>
>>>>>>> Is not that controlled with max_channels? 
>>>>>>
>>>>>> How? I would like to run the test against specific channel. That channel is
>>>>>> occupied and thus I should get an error. This is how it suppose to work and
>>>>>> actually did before your patch.
>>>>>
>>>>> Since you highlighted "ALL" I though that was an issue, yet looks like you
>>>>> expect run command would do nothing, correct?
>>>>
>>>> Yes!
>>>>
>>>>> IIUC attempt to add already occupied channel is producing error regardless of
>>>>> my patch and I do not see how error could come from run command.
>>>>
>>>> We need to save the status somewhere that the channel setter has been called
>>>> unsuccessfully. And propagate an error to the run routine.
>>>
>>> I'm not familiar with the code to propose nice and elegant solution, but for the
>>> start (build only)
>>>
>>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>>> index 45d4d92..40dba6b 100644
>>> --- a/drivers/dma/dmatest.c
>>> +++ b/drivers/dma/dmatest.c
>>> @@ -129,6 +129,7 @@ struct dmatest_params {
>>>   * @nr_channels:	number of channels under test
>>>   * @lock:		access protection to the fields of this structure
>>>   * @did_init:		module has been initialized completely
>>> + * @misconfig:		test has faced configuration issues
>>>   */
>>>  static struct dmatest_info {
>>>  	/* Test parameters */
>>> @@ -139,6 +140,7 @@ static struct dmatest_info {
>>>  	unsigned int		nr_channels;
>>>  	struct mutex		lock;
>>>  	bool			did_init;
>>> +	bool			misconfig;
>>>  } test_info = {
>>>  	.channels = LIST_HEAD_INIT(test_info.channels),
>>>  	.lock = __MUTEX_INITIALIZER(test_info.lock),
>>> @@ -1184,16 +1186,26 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>>>  		return ret;
>>>  	} else if (dmatest_run) {
>>>  		if (!is_threaded_test_pending(info)) {
>>> -			pr_info("No channels configured, continue with any\n");
>>> -			if (!is_threaded_test_run(info))
>>> -				stop_threaded_test(info);
>>> -			add_threaded_test(info);
>>> +			/*
>>> +			 * We have nothing to run. This can be due to:
>>> +			 */
>>> +			if (info->misconfig) {
>>> +				/* 1) Mis-configuration */
>>> +				pr_warn("Channels mis-configured, could not continue\n");
>>> +				goto out;
>>> +			} else {
>>> +				/* 2) We rely on defaults */
>>> +				pr_info("No channels configured, continue with any\n");
>>> +				if (!is_threaded_test_run(info))
>>> +					stop_threaded_test(info);
>>> +				add_threaded_test(info);
>>> +			}
>>>  		}
>>>  		start_threaded_tests(info);
>>>  	} else {
>>>  		stop_threaded_test(info);
>>>  	}
>>> -
>>> +out:
>>>  	mutex_unlock(&info->lock);
>>>  
>>>  	return ret;
>>> @@ -1226,6 +1238,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>>>  				strlcpy(chan_reset_val,
>>>  					dma_chan_name(dtc->chan),
>>>  					sizeof(chan_reset_val));
>>> +				info->misconfig = true;
>>>  				ret = -EBUSY;
>>>  				goto add_chan_err;
>>>  			}
>>> @@ -1246,6 +1259,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>>>  		 */
>>>  		if ((strcmp(dma_chan_name(dtc->chan), strim(test_channel)) != 0)
>>>  		    && (strcmp("", strim(test_channel)) != 0)) {
>>> +			info->misconfig = true;
>>>  			ret = -EINVAL;
>>>  			strlcpy(chan_reset_val, dma_chan_name(dtc->chan),
>>>  				sizeof(chan_reset_val));
>>> @@ -1255,6 +1269,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>>>  	} else {
>>>  		/* Clear test_channel if no channels were added successfully */
>>>  		strlcpy(chan_reset_val, "", sizeof(chan_reset_val));
>>> +		info->misconfig = true;
>>>  		ret = -EBUSY;
>>>  		goto add_chan_err;
>>>  	}
>>>
>>>>
>>>>> As for my patch it restores behaviour of how it supposed to work prior d53513d5dc28
>>>>> where run command would execute with default settings if under-configured.
>>>>
>>>> Yeah, yet another breaking patch series (I have fixed one bug in that) which
>>>> has been dumped and someone disappeared...
>>>>
>>>> Yes, and here is a corner case. I have batch script which fills sysfs
>>>> parameters with something meaningful. However, when error happens in channel
>>>> setter the run kick off, luckily, b/c of regression you have noticed, doesn't
>>>> happen.
>>>>
>>>> And this behaviour as far as I remember was previously before the d53513d5dc28.
>>>> At least I remember that I wrote my scripts few years ago and they worked.
>>>
>>> Can we actually confirm behaviour before d53513d5dc28? That would add confidence
>>> that we are doing right thing.
>>>
>>
>> An update on this?
> 
> Sorry for delay. I have tested your patch and it works for my case. Though I
> would amend it a bit (commit message is still a due).


That's good, but what about behaviour prior d53513d5dc28? Did you (or somebody
else) have a chance to confirm that it won't run with plain defaults?

> 
> From 2c4acb5fd65e53a97173d910c7155df8c0dfb3c8 Mon Sep 17 00:00:00 2001
> From: Vladimir Murzin <vladimir.murzin@arm.com>
> Date: Mon, 7 Sep 2020 17:52:15 +0100
> Subject: [PATCH 1/1] dmaengine: dmatest: 6b41030fdc790 broke dmatest badly
> 
> On 9/7/20 3:05 PM, Andy Shevchenko wrote:
>> On Mon, Sep 07, 2020 at 02:06:23PM +0100, Vladimir Murzin wrote:
>>> On 9/7/20 1:06 PM, Andy Shevchenko wrote:
> 
>>> IIUC attempt to add already occupied channel is producing error regardless of
>>> my patch and I do not see how error could come from run command.
>>
>> We need to save the status somewhere that the channel setter has been called
>> unsuccessfully. And propagate an error to the run routine.
> 
> I'm not familiar with the code to propose nice and elegant solution, but for the
> start (build only)
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmatest.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index b2790641370a..4c9a9d7b48bb 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -129,6 +129,7 @@ struct dmatest_params {
>   * @nr_channels:	number of channels under test
>   * @lock:		access protection to the fields of this structure
>   * @did_init:		module has been initialized completely
> + * @last_error:		test has faced configuration issues
>   */
>  static struct dmatest_info {
>  	/* Test parameters */
> @@ -137,6 +138,7 @@ static struct dmatest_info {
>  	/* Internal state */
>  	struct list_head	channels;
>  	unsigned int		nr_channels;
> +	int			last_error;
>  	struct mutex		lock;
>  	bool			did_init;
>  } test_info = {
> @@ -1202,10 +1204,22 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>  		return ret;
>  	} else if (dmatest_run) {
>  		if (!is_threaded_test_pending(info)) {
> -			pr_info("No channels configured, continue with any\n");
> -			if (!is_threaded_test_run(info))
> -				stop_threaded_test(info);
> -			add_threaded_test(info);
> +			/*
> +			 * We have nothing to run. This can be due to:
> +			 */
> +			ret = info->last_error;
> +			if (ret) {
> +				/* 1) Mis-configuration */
> +				pr_warn("Channel misconfigured, can't continue\n");
> +				mutex_unlock(&info->lock);
> +				return ret;

Do not you change behavour from "not run, return 0" to "not run, return error"? Wouldn't somebody
come after releases and complain that we broke her scripts?

Cheers
Vladimir


> +			} else {
> +				/* 2) We rely on defaults */
> +				pr_info("No channels configured, continue with any\n");
> +				if (!is_threaded_test_run(info))
> +					stop_threaded_test(info);
> +				add_threaded_test(info);
> +			}
>  		}
>  		start_threaded_tests(info);
>  	} else {
> @@ -1222,7 +1236,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  	struct dmatest_info *info = &test_info;
>  	struct dmatest_chan *dtc;
>  	char chan_reset_val[20];
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&info->lock);
>  	ret = param_set_copystring(val, kp);
> @@ -1230,7 +1244,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		mutex_unlock(&info->lock);
>  		return ret;
>  	}
> -	/*Clear any previously run threads */
> +	/* Clear any previously run threads */
>  	if (!is_threaded_test_run(info) && !is_threaded_test_pending(info))
>  		stop_threaded_test(info);
>  	/* Reject channels that are already registered */
> @@ -1277,12 +1291,14 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
>  		goto add_chan_err;
>  	}
>  
> +	info->last_error = ret;
>  	mutex_unlock(&info->lock);
>  
>  	return ret;
>  
>  add_chan_err:
>  	param_set_copystring(chan_reset_val, kp);
> +	info->last_error = ret;
>  	mutex_unlock(&info->lock);
>  
>  	return ret;
> 

