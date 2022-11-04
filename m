Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDB619A47
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiKDOkc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKDOkL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAE2FFF3
        for <dmaengine@vger.kernel.org>; Fri,  4 Nov 2022 07:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3CE62228
        for <dmaengine@vger.kernel.org>; Fri,  4 Nov 2022 14:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B0BC433C1;
        Fri,  4 Nov 2022 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572721;
        bh=21cUV4Pta+B4H9ld553mG+e5ajulzhjf78H2yjl8mkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N30HdoJbw5PnH6QpxueoIn6x7uShLoEboJD6UP6zyQ7aevOXy+VA/ANfNIEZVMlFM
         aYR8k6CPihCVnhDVMB9MvywVpnrdEkNsZ/PQ6WqeY/H+VvFRSUsx1yfav15hOTfeK9
         8hm1inZ42H7gfZO+/APH36ww/zBpzI6zd4pvQbztYgAZ1DYe1JaYybBCWhGgDtiKe2
         dpgFbmC8FyGO5O+utypnxOqg8F7CnrknQ/ti+HJz633QC9dhflwoTte7BwEOFsB77r
         RlU/iu2AvA1y72/InfCruL9imNMpLmJgoCVH4ISrGzuA2YS3FmK1/34ZNtpISgR6ye
         bY5EGNddy+AwQ==
Date:   Fri, 4 Nov 2022 20:08:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     dmaengine@vger.kernel.org, vigneshr@ti.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: fix memory leak when
 register device fail
Message-ID: <Y2Uj7TTAz+wJfAxZ@matsya>
References: <20221020062827.2914148-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020062827.2914148-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-22, 14:28, Yang Yingliang wrote:
> If device_register() fails, it should call put_device() to give
> up reference, the name allocated in dev_set_name() can be freed
> in callback function kobject_cleanup().

Applied, thanks

-- 
~Vinod
