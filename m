Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771D6BF016
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCQRrE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCQRrD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801874E5F5;
        Fri, 17 Mar 2023 10:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FD860F30;
        Fri, 17 Mar 2023 17:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E11BC433EF;
        Fri, 17 Mar 2023 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075221;
        bh=g3D9UlthErJgQKx8E+92yEXHrLI/cWb05adOnPrNrwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tp8gWNSUZimamExfxl0Gd27Z1pMSa6Vmri1x/Kgv0sbdWSH47OfVgZXSN4+WieD+Z
         dqc4I+eqS2rQrtMs8YzxrYlmMa0+UornrQ7W2J1hCCUj9gxD8mH0WWs+hcdGt9CqOF
         E/PCKZQK9GnNKkj0qnDEXtq9nro4i0Jsfpbd+3KMpdDSP+WxrbcJTC8v74I39FvzOa
         EBXZvRIby/axAh7WraV15jFVU0F9ZOyMxG3juhzYgbj8mTnQCvwNBWt1yFWZG3jdmO
         uoQEnFPAoGNitrGSXV/1CYKBTPd9jKCdbNS5z9FyvOottoKJxmtOI8Mp2yICekraZm
         S/FUaMMqfWUJA==
Date:   Fri, 17 Mar 2023 23:16:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
Message-ID: <ZBSnkdedr568FBiv@matsya>
References: <20230307192655.874008-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307192655.874008-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-03-23, 13:26, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
> which appeared in v6.0, the PCI core has enabled PCIe error reporting for
> all devices during enumeration.
> 
> Remove driver code to do this and remove unnecessary includes of
> <linux/aer.h>.

Applied, thanks

-- 
~Vinod
