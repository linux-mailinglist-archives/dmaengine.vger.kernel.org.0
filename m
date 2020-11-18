Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983B42B812E
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKRPuo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 10:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgKRPuo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 10:50:44 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC55247AF;
        Wed, 18 Nov 2020 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605714643;
        bh=atXI3IGFAZhuwWZNfCRfTF5//pdQnE6WVrE6bXlpwjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nH93ycB/F7MR29usBTZIMKaeoHZrLvvOdw6d5hPaB6BCtdZlGwiQu+iLEpjVe6IhK
         6SPiM9/JJ5eyvV5q5bFLZvg2hIlgqD1BJ2JYPvO2HtiFDqvGAM+romswwkrbGrMwhV
         2BuOW49lo+TOW1AtYcBv2/AaFrQr2r7p1tnwsE60=
Date:   Wed, 18 Nov 2020 21:20:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Pedersen <twp@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: qcom: Add ADM driver
Message-ID: <20201118155038.GU50232@vkoul-mobl>
References: <20200916064326.GA13963@earth.li>
 <20200919185739.GS3411@earth.li>
 <20200920181204.GT3411@earth.li>
 <20200923194056.GY3411@earth.li>
 <20201114140233.GM32650@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114140233.GM32650@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-11-20, 14:02, Jonathan McDowell wrote:
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
> The hardware only supports a 32 bit physical address, so specifying
> !PHYS_ADDR_T_64BIT gives maximum COMPILE_TEST coverage without having to
> spend effort on kludging things in the code that will never actually be
> needed on real hardware.

Applied, thanks

My build scripts emit the warnings below, please fix them up with the
follow up patch. You can get this with W=1

drivers/dma/qcom/qcom_adm.c:180: warning: Function parameter or member 'chan' not described in 'adm_free_chan'
drivers/dma/qcom/qcom_adm.c:190: warning: Function parameter or member 'burst' not described in 'adm_get_blksize'
drivers/dma/qcom/qcom_adm.c:466: warning: Function parameter or member 'chan' not described in 'adm_terminate_all'
drivers/dma/qcom/qcom_adm.c:466: warning: Excess function parameter 'achan' description in 'adm_terminate_all'
drivers/dma/qcom/qcom_adm.c:503: warning: Function parameter or member 'achan' not described in 'adm_start_dma'

-- 
~Vinod
