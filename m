Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67445EC28
	for <lists+dmaengine@lfdr.de>; Fri, 26 Nov 2021 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhKZLHq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 06:07:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59840 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231894AbhKZLFp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 06:05:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AQAPkmC005504;
        Fri, 26 Nov 2021 12:02:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rIVNndVjXrp5d2vbUEdWXvWy8JriPvwm7z8e0plOV8o=;
 b=DYeiB1ASDEfc3h7i3EXJwUtyZexhb+hIbJZJNAOecqXrtAu0mBdGvVmgRMz4MKENdgl6
 c70+raJq/RV1dDmVtrXgAmJiLk98sXR35NknHvZ4jT2CduP4MsvlsNPLhJglj3mAoE+Y
 /WkpcOQZzb5LMCf7r2fZA+rtgShZvXyCAXBqTk/ak+BeU1ZbGpYX8bsiFqx8cqnxRAom
 Q1deeSFjBzoi/Mf+UDRU1PsgE7ej7MA5LixeESFGE0mHnSgwnKIuwvOpvxMj3tRPWZUI
 /HmYShZsTte1WlaetaaRyDq/X34HhJku9dJnA6O4FHK02ujXo+2q0VLaUvsUzX0XUULR 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjnmfavvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 12:02:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4374210002A;
        Fri, 26 Nov 2021 12:02:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2221B2248D3;
        Fri, 26 Nov 2021 12:02:10 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 26 Nov
 2021 12:02:09 +0100
Subject: Re: [Linux-stm32] [PATCH] dmaengine: stm32-mdma: Use bitfield helpers
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <36ceab242a594233dc7dc6f1dddb4ac32d1e846f.1637593297.git.geert+renesas@glider.be>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <fc8aec08-0dfe-0a2d-01a2-084e0c26f6fb@foss.st.com>
Date:   Fri, 26 Nov 2021 12:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <36ceab242a594233dc7dc6f1dddb4ac32d1e846f.1637593297.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_03,2021-11-25_02,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 11/22/21 4:54 PM, Geert Uytterhoeven wrote:
> Use the FIELD_{GET,PREP}() helpers, instead of defining custom macros
> implementing the same operations.
> 
> Signed-off-by: Geert Uytterhoeven<geert+renesas@glider.be>


Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Tested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
> Compile-tested only.
> 
> See "[PATCH 00/17] Non-const bitfield helper conversions"
> (https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
> for background and more conversions.
> ---
>   drivers/dma/stm32-mdma.c | 74 +++++++++++++---------------------------
>   1 file changed, 23 insertions(+), 51 deletions(-)

Regards,
Amelie
