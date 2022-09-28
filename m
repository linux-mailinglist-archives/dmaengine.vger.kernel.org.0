Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDF5ED2BD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiI1BqW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 21:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiI1BqV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 21:46:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E822297
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 18:46:19 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McfRP4k26zHqL0;
        Wed, 28 Sep 2022 09:44:01 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 09:46:18 +0800
Message-ID: <62a48530-5019-e48a-4aea-58393f792a6f@huawei.com>
Date:   Wed, 28 Sep 2022 09:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] dmaengine: idxd: Remove unused struct idxd_fault
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20220927133711.98184-1-yuancan@huawei.com>
 <IA1PR11MB6097DCF0628FC0462656AB109B559@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Yuan Can <yuancan@huawei.com>
In-Reply-To: <IA1PR11MB6097DCF0628FC0462656AB109B559@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

在 2022/9/28 7:35, Yu, Fenghua 写道:
> Hi, Yuan,
>
>> After commit 0e96454ca26c("dmaengine: idxd: remove fault processing code"),
>> no one use struct idxd_fault, so remove it.
> How about this commit message?
>
> Since fault processing code has been removed, struct idxd_fault is not used any more and can be removed as well.
>
> Fixes: commit 0e96454ca26c ("dmaengine: idxd: remove fault processing code")

Yes, this commit message seems better, let me resend with that.

thanks for your advice!

Best regards,

Yuan Can

