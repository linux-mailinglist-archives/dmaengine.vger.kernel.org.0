Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB3123F89
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfLRG0o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 01:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRG0o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 01:26:44 -0500
Received: from localhost (unknown [27.59.34.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C8C218AC;
        Wed, 18 Dec 2019 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576650403;
        bh=IK/FjFg1xZHL7wLM+UX88DTotTKCGLqYwJTRt2V3I/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBJC8A0O9tpiMjJzF/kNuFLIDRrX1CHmVZRMXGE9BBl7ck42YkXH8ihlYKNHSZIvg
         dWHG0FUpOSTTL5LWbxBPbKETj8vJkRFCcgJLnBO31hFyg/nbq4BX5Uih+mZD6qMz8b
         vzB1WOfeenXz1zt2e7sjkyoV3XrCk4Yg0lt2OtmQ=
Date:   Wed, 18 Dec 2019 11:56:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Message-ID: <20191218062636.GS2536@vkoul-mobl>
References: <20191212033714.4090-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212033714.4090-1-peng.ma@nxp.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-12-19, 03:38, Peng Ma wrote:
> Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
> below registers(CHCFG0 - CHCFG15) of eDMA as follows:
> *-----------------------------------------------------------*
> |     Offset   |	OTHERS			|		LS1028A			|
> |--------------|--------------------|-----------------------|
> |     0x0      |        CHCFG0      |           CHCFG3      |
> |--------------|--------------------|-----------------------|
> |     0x1      |        CHCFG1      |           CHCFG2      |
> |--------------|--------------------|-----------------------|
> |     0x2      |        CHCFG2      |           CHCFG1      |
> |--------------|--------------------|-----------------------|
> |     0x3      |        CHCFG3      |           CHCFG0      |
> |--------------|--------------------|-----------------------|
> |     ...      |        ......      |           ......      |
> |--------------|--------------------|-----------------------|
> |     0xC      |        CHCFG12     |           CHCFG15     |
> |--------------|--------------------|-----------------------|
> |     0xD      |        CHCFG13     |           CHCFG14     |
> |--------------|--------------------|-----------------------|
> |     0xE      |        CHCFG14     |           CHCFG13     |
> |--------------|--------------------|-----------------------|
> |     0xF      |        CHCFG15     |           CHCFG12     |
> *-----------------------------------------------------------*
> 
> This patch is to improve edma driver to fit LS1028A platform.

Applied this and patch 3, thanks

Btw pls send bindings as patch1 and driver changes as patch2.
-- 
~Vinod
