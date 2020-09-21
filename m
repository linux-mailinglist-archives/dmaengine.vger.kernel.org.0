Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE5271E35
	for <lists+dmaengine@lfdr.de>; Mon, 21 Sep 2020 10:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIUImH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 21 Sep 2020 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUImD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Sep 2020 04:42:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D81C061755
        for <dmaengine@vger.kernel.org>; Mon, 21 Sep 2020 01:42:03 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKHOT-0003EY-Gt; Mon, 21 Sep 2020 10:41:53 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKHOR-0005hZ-U1; Mon, 21 Sep 2020 10:41:51 +0200
Message-ID: <e6848ae656e8e49ced429226d716f2b29cecfcba.camel@pengutronix.de>
Subject: Re: [PATCH v3] dmaengine: qcom: Add ADM driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jonathan McDowell <noodles@earth.li>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Pedersen <twp@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 21 Sep 2020 10:41:51 +0200
In-Reply-To: <20200920181204.GT3411@earth.li>
References: <20200916064326.GA13963@earth.li>
         <20200919185739.GS3411@earth.li> <20200920181204.GT3411@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jonathan,

On Sun, 2020-09-20 at 19:12 +0100, Jonathan McDowell wrote:
> Add the DMA engine driver for the QCOM Application Data Mover (ADM) DMA
> controller found in the MSM8x60 and IPQ/APQ8064 platforms.
> 
> The ADM supports both memory to memory transactions and memory
> to/from peripheral device transactions.  The controller also provides
> flow control capabilities for transactions to/from peripheral devices.
> 
> The initial release of this driver supports slave transfers to/from
> peripherals and also incorporates CRCI (client rate control interface)
> flow control.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
[...]

> +static int adm_dma_probe(struct platform_device *pdev)
> {
[...]
> +	adev->core_clk = devm_clk_get(adev->dev, "core");
> +	if (IS_ERR(adev->core_clk))
> +		return PTR_ERR(adev->core_clk);
> +
> +	ret = clk_prepare_enable(adev->core_clk);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to prepare/enable core clock\n");
> +		return ret;
> +	}

It is better to only start enabling the hardware after all resources
have been acquired, see below.

> +	adev->iface_clk = devm_clk_get(adev->dev, "iface");
> +	if (IS_ERR(adev->iface_clk)) {
> +		ret = PTR_ERR(adev->iface_clk);
> +		goto err_disable_core_clk;
> +	}

Move this up before the core_clk enable, and you can directly return the
error.

> +
> +	ret = clk_prepare_enable(adev->iface_clk);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to prepare/enable iface clock\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	adev->clk_reset = devm_reset_control_get(&pdev->dev, "clk");
> +	if (IS_ERR(adev->clk_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 reset\n");
> +		ret = PTR_ERR(adev->clk_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c0_reset = devm_reset_control_get(&pdev->dev, "c0");
> +	if (IS_ERR(adev->c0_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C0 reset\n");
> +		ret = PTR_ERR(adev->c0_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c1_reset = devm_reset_control_get(&pdev->dev, "c1");
> +	if (IS_ERR(adev->c1_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C1 reset\n");
> +		ret = PTR_ERR(adev->c1_reset);
> +		goto err_disable_clks;
> +	}
> +
> +	adev->c2_reset = devm_reset_control_get(&pdev->dev, "c2");
> +	if (IS_ERR(adev->c2_reset)) {
> +		dev_err(adev->dev, "failed to get ADM0 C2 reset\n");
> +		ret = PTR_ERR(adev->c2_reset);
> +		goto err_disable_clks;
> +	}

Please use devm_reset_control_get_exclusive(). Move these up before the
core_clk enable, and you can directly return the error.

regards
Philipp
