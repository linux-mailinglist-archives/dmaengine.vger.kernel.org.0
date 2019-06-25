Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47FE521D2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFYEP1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYEP1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:15:27 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00BA20659;
        Tue, 25 Jun 2019 04:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561436126;
        bh=yiFX7jrnzfFDLJD+nZSTKbVmX0FksTqWGaKxBhnQdGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOHh1ZCQPvSJUEOQ1v0P0F7Xp/ZdZFJSlLQmvLls0ZxvnMFyRLt+t4zd7W5pxYy7J
         X6a2MbZtxa/Fdiz7V7DfvHFksuLa5H79xI1gNSpdCiU9TNiE7q4kSDwWyBsIPwMtki
         3kT+nhdM7POHUElZ1UsjskwtvoHFv0uJ2O5yQpiw=
Date:   Tue, 25 Jun 2019 09:42:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, dan.j.williams@intel.com,
        angelo@sysam.it, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 1/6] dmaengine: fsl-edma: add drvdata for fsl-edma
Message-ID: <20190625041216.GE2962@vkoul-mobl>
References: <20190614081724.13366-1-yibin.gong@nxp.com>
 <20190614081724.13366-2-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614081724.13366-2-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-19, 16:17, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> There are some differences between vf610 and next i.mx7ulp. Put such
> differences into static driver data for distiguish easily at driver

Typo distiguish 

Though I tried to apply 1-5 it doesnt apply for me, can you rebase and
resend

Thanks

-- 
~Vinod
