Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75310619A88
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKDOtE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiKDOsq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8C31DC8;
        Fri,  4 Nov 2022 07:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4912F62239;
        Fri,  4 Nov 2022 14:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F01C433C1;
        Fri,  4 Nov 2022 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573311;
        bh=gCkIm11TczXuHf2G/XSOXU9X+j/bqcP+zUEZpbuotS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLVHD9T9kjqbotHk7IAU0wxPq7X8FuiqUFZrDexOufSEk2Yz3GEDRyhzLA2GbiJBl
         GUoQcp6WmrE8Ioskn3pAUpS1a2YKCjlOU+4CPztE5A8saX9Kj2KZOL532/PtTe8pGl
         gpILo10+Pw+qZjmuHnegBJiNSkQ9CHrK2mtbQcpkDsWMjanI5fyZD6Xexk6GeRIRhB
         +6jYun80U3iDbLOD9I1AthddnQJw9Yut71gDtmiLFXrf2uAMuLnclQzrBztic6JME+
         3/B1Ejwv/031MoBsjmHHndEVzDixxwUYL3+CLZhgBs+4NzHfLpwO29+Dzm2Se+27rM
         wOZRh2rFqpNRw==
Date:   Fri, 4 Nov 2022 20:18:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: devres: add missing
 devm_acpi_dma_controller_free() helper
Message-ID: <Y2UmO9/vs5+dQFT7@matsya>
References: <20221102022701.1407289-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102022701.1407289-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-11-22, 10:27, Yang Yingliang wrote:
> Add missing devm_acpi_dma_controller_free() to devres.rst, it's introduced
> by commit 1b2e98bc1e35 ("dma: acpi-dma: introduce ACPI DMA helpers").

Applied, thanks

-- 
~Vinod
