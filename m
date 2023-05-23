Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0870E044
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjEWPUc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjEWPUb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 11:20:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA398185;
        Tue, 23 May 2023 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IwWt8vm7YxokOuC3jq5/50QuiT4RbHvoQwVnGhf4iNQ=; b=txnGef5Iy6+K4m6cCJI53kCfJP
        9YlrYhFEVXZ/e+zxsxl6tGrvVyceNIKnqDpS6+PYQMuAVxmyUln+aNkK9Pqwj+xRzrtoGmNZWFOED
        lbIrvSLhGFUY7BbZY6/U8sC8FYX+rZJjgtHHJ58wZ0D3e0NWUuCyX6qNDH91/dCPmDvN1IiiW260m
        gmgUfCTu1oJB6m8J0tp3phRE+ZprQB6o9Xnq8oqzqR/KomVZ3iNGMw6sQZ7ch7DodmS8/rX2p9Gtv
        1LBIcROOWkEWmexLOBE5xHfOGNPTfIyvjOVix/YpDeBPCokMEigpmol8FWSRAZimBArIe88uS16yi
        DFGxlLZQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1ToI-00AcZ9-0L;
        Tue, 23 May 2023 15:20:26 +0000
Message-ID: <09f31255-e214-01d7-318a-13d712f73837@infradead.org>
Date:   Tue, 23 May 2023 08:20:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dmaengine: pl330: rename _start to prevent build error
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Jaswinder Singh <jassi.brar@samsung.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230523000606.9405-1-rdunlap@infradead.org>
 <ZGzI+gsYdF6kEHFk@matsya>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZGzI+gsYdF6kEHFk@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/23/23 07:08, Vinod Koul wrote:
> On 22-05-23, 17:06, Randy Dunlap wrote:
>> "_start" is used in several arches and proably should be reserved
>> for ARCH usage. Using it in a driver for a private symbol can cause
>> a build error when it conflicts with ARCH usage of the same symbol.
>>
>> Therefore rename pl330's "_start" to "_start_thread" so that there
>> is no conflict and no build error.
> 
> Why not rename to pl330_start or pl330_start_thread to ensure we will
> might not conflict ever!
> 

Ok, will do. Thanks.

-- 
~Randy
