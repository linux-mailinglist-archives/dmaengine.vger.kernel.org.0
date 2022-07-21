Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB957CABD
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGUMi7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMi6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C67538E
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 05:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA3561DB9
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 12:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73F2C3411E;
        Thu, 21 Jul 2022 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658407137;
        bh=wLUqTMYCq0OJ6Sgz6zPJmyxlCEE3tip9kaE3XUSKUW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hB4njbose2neSUyFnUsApeQezAGgzUmnXHZbRbjZPdABJUmkELb95IZn5CVraUAiI
         rH8KOcGJCgWbfX8I1IikBw+o/7nyEjCBfSRIT44eAqajLPQv17gfES5xvWONKOSIkB
         a5RBXrDaKbTnD+8AtGk1JIG8g1nY8Hbv3IQpKXwXz8u4wKhEcpX2GZcn4tytWesDk1
         nuS0YFyONhyD4xhI2TmAeWapy6mm4LtmTnvdNX/dd9UPvhZ9VHbo8YB/ZqSCZcR0U7
         g7Y8+I3wm+Mnr0XhxaWFIHE0Q0XxTpcAMTg6tsfDA07HSOV7N3XzCH7rmthHLdSw9V
         vvf7Z75N1kDGg==
Date:   Thu, 21 Jul 2022 18:08:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] dmaengine: imx-dma: Cast of_device_get_match_data()
 with (uintptr_t)
Message-ID: <YtlI3Vp0HpegHSki@matsya>
References: <20220706111327.940764-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706111327.940764-1-festevam@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-22, 08:13, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Change the of_device_get_match_data() cast to (uintptr_t)
> to silence the following clang warning:

Applied, thanks

-- 
~Vinod
