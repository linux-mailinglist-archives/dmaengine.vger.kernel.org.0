Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409E92AD1F9
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 10:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKJJCu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Tue, 10 Nov 2020 04:02:50 -0500
Received: from aposti.net ([89.234.176.197]:36664 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJJCt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 04:02:49 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2020 04:02:48 EST
Date:   Tue, 10 Nov 2020 08:54:11 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND 0/2] Add dmaengine bindings for the JZ4775 and the
 X2000 SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     Zubair.Kakakhel@imgtec.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <BQOKJQ.FNG5W5HD7VTG1@crapouillou.net>
In-Reply-To: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
References: <20201107122016.89859-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zhou,

Le sam. 7 nov. 2020 à 20:20, 周琰杰 (Zhou Yanjie) 
<zhouyanjie@wanyeetech.com> a écrit :
> Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC from 
> Ingenic.
> 
> 周琰杰 (Zhou Yanjie) (2):
>   dt-bindings: dmaengine: Add JZ4775 bindings.
>   dt-bindings: dmaengine: Add X2000 bindings.
> 
>  include/dt-bindings/dma/jz4775-dma.h | 44 
> +++++++++++++++++++++++++++++
>  include/dt-bindings/dma/x2000-dma.h  | 54 
> ++++++++++++++++++++++++++++++++++++

If that's up to me, these macros aren't really needed, and you can put 
the values directly in the dma cells. This is done already in 
jz4740.dtsi, jz4725b.dtsi and jz4770.dtsi.

Cheers,
-Paul

>  2 files changed, 98 insertions(+)
>  create mode 100644 include/dt-bindings/dma/jz4775-dma.h
>  create mode 100644 include/dt-bindings/dma/x2000-dma.h
> 
> --
> 2.11.0
> 


