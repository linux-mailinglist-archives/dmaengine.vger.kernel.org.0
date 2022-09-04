Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B6B5AC599
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiIDRMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiIDRMy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 13:12:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3DD1E3F3;
        Sun,  4 Sep 2022 10:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DADAB80D5A;
        Sun,  4 Sep 2022 17:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBBDC433C1;
        Sun,  4 Sep 2022 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311571;
        bh=aszDg7CyTk1xQXOHSsPPHhkY6mzYCRV6UtfJ6gDqOBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCIWAGsyMuQTm/ZB7ba5+1NoejZVxZMiuDHsgiDl3yblEbALSOfds+0rGPOMuZbnr
         iFWqKkB2voCCITnTmcJsuBkOnY6BrrJmk6lhvIQ38XNBNprAUBXcF8nA+FuVAFmpeC
         JWFRjp79wm/Sh2g9GpHH9wY0uXqzazazeNL9jXyZEtvUgfwVl9qfNzjqXreFD7hSsm
         m9L2bjyDaI5hb/xVZVi6mxzSU+m/1MqQaIvFJ49o4h/omAavrocoa8SqKuWHnRBgwV
         unQnrqze9ZrvB+rqDW4r76hS4O8LuUxegnhqhV6fifipDAcUM7ba1KG3xnaeaN34sL
         jPFugeIGaVUnQ==
Date:   Sun, 4 Sep 2022 22:42:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v5 0/7] dmaengine: hisilicon: Add support for hisi
 dma driver
Message-ID: <YxTcjiHYbOMmANYE@matsya>
References: <20220830062251.52993-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830062251.52993-1-haijie1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-08-22, 14:22, Jie Hai wrote:
> The HiSilicon IP08 and HiSilicon IP09 are DMA iEPs, they share the
> same pci device id but different pci revision and register layouts.

Applied, thanks

-- 
~Vinod
