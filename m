Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F99705547
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEPRrJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPRrI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167701BC3;
        Tue, 16 May 2023 10:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CDC63D49;
        Tue, 16 May 2023 17:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFCDC433EF;
        Tue, 16 May 2023 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259227;
        bh=q3lk1/GMYHuiihYLYFSQOAgj5CokDV7UTM+ye9181iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iz8PRA4HTwIsqjONlPlw0laxnPtgLZG4+WyhGLa28ShQvytQ9QTrz8b8N1L3/hwpi
         jUhjlfDNVLiHOc8Bp1IoL4Z+fpI9KE6oF/LaXELa8DcTdODrMyZqdRslP9pN8eq/PM
         q57v9BajZBLGEs0d3NWLIepM4zP2uLGw80nIc5ept+vgCe3HzG/zxOB5/2cIFwt5yu
         crNFtxwBZOHqoO6yGo8tJiTOnPVKsNY2mO0FeX0i3Yy6kxl3FxVwK+Gvh5pip8Ys7C
         +TaAuc7gZ2nij0MNaQu9QlEeuckdymo1cf6tTLixbAqEmsZZSqK8Jc9mncyfI0yEkQ
         XeJJh3hY059Qw==
Date:   Tue, 16 May 2023 23:17:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
Message-ID: <ZGPBliJGmVq4Y36h@matsya>
References: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-23, 13:40, Michal Simek wrote:
> DP DMA has own power domain that's why describe required power-domain
> property.

Applied, thanks

-- 
~Vinod
