Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9646E4E92
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjDQQuu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQQut (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 12:50:49 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAC526A;
        Mon, 17 Apr 2023 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=7vXipZ/UwJBW0uB9csVn0cpof8IbwzgFkLpm2tMHzig=; b=DRb+ktBgy9dy7gp9xLzNPGyTsM
        ReNOA6XrzUnwkCS4xxBitS7Y7sFiFDDbjcZn11nncoNe7E+DeVD7CZGmcZ9IHdBpiieGoF6HoP2jG
        9JrW1JVq6rC+zQL6vMnOb/P+EZ0N+ynrj+YrpqeRCLmbPx8E2Cu4C5EdHfCorXORyec4XEXwiCgcA
        FVlL1KoSOSx+7Bd1wMccBWfdXWkjQ8erbEP4e/ZkyiElbWLYplfNhLztp7sRhwp/V8+MTlbqD4J2H
        Y/lgc817r7FSMb6zR/nRDuM+YMFT475IQFHhh6f7VbIVS8SHkaoULPs9oHxDTM50ozfbMZuYVYYQB
        dP464ERg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1poS3e-00Azru-5V; Mon, 17 Apr 2023 10:50:26 -0600
Message-ID: <694b79c7-b88a-bccf-d026-690cd3ccffee@deltatee.com>
Date:   Mon, 17 Apr 2023 10:50:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Jisheng Zhang <jszhang@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20230415095517.2763-1-jszhang@kernel.org>
 <20230415095517.2763-4-jszhang@kernel.org>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230415095517.2763-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jszhang@kernel.org, lars@metafoo.de, vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2 3/5] dmaengine: plx_dma: Don't set chancnt
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023-04-15 03:55, Jisheng Zhang wrote:
> The dma framework will calculate the dma channels chancnt, setting it
> ourself is wrong.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Seems fine to me.

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
