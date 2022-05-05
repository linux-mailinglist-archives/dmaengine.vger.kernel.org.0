Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAB51BDE2
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 13:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiEELUw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiEELUv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 07:20:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68550B05;
        Thu,  5 May 2022 04:17:12 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458kkDS026502;
        Thu, 5 May 2022 13:17:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7F7Qd30mMslQ1ChrIB5EqTtg88WpZEdEmh+pFm3iuAc=;
 b=mTpA0I5YO+hfAqUnQWSWa2Lm9y5U2jzV6kyFng8CO6JBzQYSQLFql3PlG5a8wk0/R/1l
 i+/JkUGgmBQF1bONp53dqDS8lJBGjijGzNsZg0UZalERxT4BWQ7e45OgoGdtnIF4lQXU
 9QIZ7maKFaa17B64s0gqXLa0EhocnM0nGawL1ckY8fBtb36tU7JdEQqBB6spfznqwTA4
 aUrpsTvtWPf0oQJJLojuUe02U51Vp+72+F9ctLZvQjnWeA+zUlwokypYhEeG/VVVyrKk
 v3vxB0jB28tPlZMeBvX9V2P5c8PyC5c+x8tVR0JMUei6+y64+eH95mXeab5y2Ua81x3l TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt893f5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:17:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F14710002A;
        Thu,  5 May 2022 13:16:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5965121A20A;
        Thu,  5 May 2022 13:16:54 +0200 (CEST)
Received: from [10.211.8.113] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May
 2022 13:16:53 +0200
Message-ID: <5d5fcb7b-0ef9-09b2-30a8-c6b452fdd90b@foss.st.com>
Date:   Thu, 5 May 2022 13:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/4] STM32 DMA pause/resume support
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220505111434.37274-1-amelie.delaunay@foss.st.com>
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20220505111434.37274-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Please drop this series, truncated :(

On 5/5/22 13:14, Amelie Delaunay wrote:
> This patchset introduces pause/resume support in stm32-dma driver.
> [1/4], [2/4] and [3/4] ease the introduction of device_pause/device_resume
> ops management in [4/4].
> 
> Amelie Delaunay (4):
>    dmaengine: stm32-dma: introduce stm32_dma_sg_inc to manage
>      chan->next_sg
>    dmaengine: stm32-dma: pass DMA_SxSCR value to
>      stm32_dma_handle_chan_done()
>    dmaengine: stm32-dma: rename pm ops before dma pause/resume
>      introduction
>    dmaengine: stm32-dma: add device_pause/device_resume support
> 
>   drivers/dma/stm32-dma.c | 311 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 268 insertions(+), 43 deletions(-)
> 
