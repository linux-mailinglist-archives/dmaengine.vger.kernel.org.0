Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E222B7BEA
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 11:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKRK4w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 05:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgKRK4w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 05:56:52 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8007B21D7E;
        Wed, 18 Nov 2020 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605697011;
        bh=Ur8csfkvHK98xjlK0nH3wljSecIkUkEQFfNFT13p7nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbMZ55JQg5XPBtaNE4yCoNCEic/GZlUhRbs6Kx0zQSrueSGwKTsseQR9WnXLpW1VV
         aHuQSJRtA6MKzAAgFrNr6xigWu9Nx32W4kCnpcWE1MpIULxFEPcmz1KABGOw18JNij
         RH56/EjUyf2HOJjXPxjjFpaNJNS2Xs9GwZ8E+vbA=
Date:   Wed, 18 Nov 2020 16:26:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Zubair.Kakakhel@imgtec.com, paul@crapouillou.net,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: Re: [PATCH RESEND 0/2] Add dmaengine bindings for the JZ4775 and the
 X2000 SoCs.
Message-ID: <20201118105647.GN50232@vkoul-mobl>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-11-20, 20:20, 周琰杰 (Zhou Yanjie) wrote:
> Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC from Ingenic.
> 
> 周琰杰 (Zhou Yanjie) (2):
>   dt-bindings: dmaengine: Add JZ4775 bindings.
>   dt-bindings: dmaengine: Add X2000 bindings.

Applied, thanks

-- 
~Vinod
