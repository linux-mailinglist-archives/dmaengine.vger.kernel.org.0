Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95182782AF0
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjHUNwS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjHUNwP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8737F4
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 06:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7DD5637CC
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 13:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E63C433C9;
        Mon, 21 Aug 2023 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625927;
        bh=fB9551JKqqrPuCF3+YFmjcnoqU/x9L9fquLf1URY2yk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jQ2+0k7QoUXM3Z9H5Fc/doGytTUxePEsvE8Cadz0ez6iUpQFwAQo1vIIj3ChMt8z+
         goJnlSEaM3PlvBCz9KBb35ruDoV09ezn6qkEkuSMICQQfXywbVxlyAUisMYNZ1UfUW
         iskXVpcEDpyAUC1lB2VrN3nsPsxthEebx7ufP25KBNrlz3gRO+jZxeeWVYuCrqeWTG
         4acwk+mQHZntYP3wxO9lSCp9P6onHFIoPrwRVsPco/6WpeCB44h1kHv/7j8JGhBqAn
         a++M6jXuFkhbwLpAUTv8nAB+UuAr+ZDlvDpqZcc1jNbfrfLpc+UVHg0PMDtm9OethL
         PdHyOxyPY1mPA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     dmaengine@vger.kernel.org, liwei391@huawei.com,
        wangxiongfeng2@huawei.com
In-Reply-To: <20230815023821.3518007-1-zhangjialin11@huawei.com>
References: <20230815023821.3518007-1-zhangjialin11@huawei.com>
Subject: Re: [PATCH] dmaengine: ioatdma: use pci_dev_id() to simplify the
 code
Message-Id: <169262592562.224153.1715285733731918408.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 15 Aug 2023 10:38:21 +0800, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> 

Applied, thanks!

[1/1] dmaengine: ioatdma: use pci_dev_id() to simplify the code
      commit: c65029b13b67b1bef9a7326ea042b58e3aa81f6f

Best regards,
-- 
~Vinod


