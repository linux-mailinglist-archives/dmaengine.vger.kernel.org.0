Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4796272EE
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiKMW32 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMW31 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 17:29:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACA9FC3;
        Sun, 13 Nov 2022 14:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DA8B80CAC;
        Sun, 13 Nov 2022 22:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0EEC433D6;
        Sun, 13 Nov 2022 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668378564;
        bh=IzhUbUa2reYvd40FIoS65Tdi/cAobstZcJ+7dKFI7B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuuCwvspywOwDDuLKIwp5aDAXYHu3C70+AAj5ySSIbJB7aIgRcXlONCmU2W+M5+Oc
         eAnxQIzNutGXO0ihkFfAHWBTYbnJFAMzrOV8f6eJMqI3wCdXSPmjbf/zF/icGdiPpr
         O/rrlcdfzj/Qn4BEiq1ZjTw5hL9dAZqV2TWa29TseytHyXTADnzSxsDi/YPREtM4YF
         hM7fyX9O8gcl5g0PikdLplH+T4Bt9Art7a7RuoxfC7AtMwe32Oh8ruHDy8bHZ2vnaQ
         bavGfJ0Ur3pE8vh+yf6+iZrYbBJMhgoSscvcu2Up7E7L8cxe5J53uXy8tYvrAQKp14
         inkjQGP/X4zTA==
Date:   Mon, 14 Nov 2022 03:59:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [patch 05/10] dmaengine: idxd: Remove linux/msi.h include
Message-ID: <Y3FvwLq7fpMTjNBF@matsya>
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.573536003@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113202428.573536003@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-11-22, 21:34, Thomas Gleixner wrote:
> Nothing in this file needs anything from linux/msi.h

Applied, thanks

-- 
~Vinod
