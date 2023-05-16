Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532870434F
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 04:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEPCSG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEPCSF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 22:18:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109A4C35;
        Mon, 15 May 2023 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=b9h7rRhrPOxichUsL50pCkVIBukrVDxbnBKuOLdJ4yM=; b=LV8cINvKHs3cE0Uzx5kVaUKoV+
        0UpXG5ZjCOeMH99ITTD83+AP4X/QcfI6ke70phiyHxX4MzxVvd3nhzV+IV52Knz8ffXl49uVmF+8H
        UI+PSUdSq/ObTCz7I9i+1/Jq7abZ1+7di/SaPOrGMEXkCkWg0hUuzpqjiwj47PDb1juGFjIzRdt5a
        mFeITZd4yIArOmgZPrH72P82L4Gg0yra+w7F2eJRkq4RcuGJlL3gViN5NVFtKBJNR3HjRC+9sdEvV
        nzHTnkN52mI3RV9oyXlwI2sBqIc5IeM/CS9oqOngmED/obcbIdldRhPfbdnSRGsMV53EbHNN69Lrn
        LwCb2t/A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pykGJ-0047TA-0c;
        Tue, 16 May 2023 02:18:03 +0000
Message-ID: <abc2472d-34f1-069b-00c8-66b751158fa9@infradead.org>
Date:   Mon, 15 May 2023 19:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (drivers/dma/ti/k3-udma.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
References: <20230515141235.0777c631@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230515141235.0777c631@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi--

On 5/14/23 21:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230512:
> 
> New trees:	fastrpc, wpan-staging
> 

This build problem has been around for a few days/weeks/?.

# CONFIG_SUSPEND is not set

../drivers/dma/ti/k3-udma.c:5552:12: warning: 'udma_pm_resume' defined but not used [-Wunused-function]
 5552 | static int udma_pm_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
../drivers/dma/ti/k3-udma.c:5530:12: warning: 'udma_pm_suspend' defined but not used [-Wunused-function]
 5530 | static int udma_pm_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~


-- 
~Randy
