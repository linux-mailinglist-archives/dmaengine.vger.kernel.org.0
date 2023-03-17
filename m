Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC66BF036
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCQRx0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCQRxW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529D99240;
        Fri, 17 Mar 2023 10:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B3E6103A;
        Fri, 17 Mar 2023 17:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90472C433D2;
        Fri, 17 Mar 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075598;
        bh=K7AS9eG4BG8X7ACaQcl0gNrVqrTznv06MYTvsbEb2zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBaBJryq/m4LBp53d3If3uuiKB2DiW7YPLmdnP+Lvzb1pCTdz3aB1RBc7OO0h+DwU
         hz7tQx9lM8Z5y5jh/vlYY7sPbZHms0QqizVK9/rIsGz++9GTokA1SslNyK8qngWdiz
         LBe8w1GAu0hmeGuqD1tliMs37X2He++LnKeS0dznFHHi1SmkQX+HBvSXspT9b9QGpy
         5TlfuWBtuDzfS1oe7JReu0h3wf9sNE19UxgQYqkof+poIRqkVy4sSiJRXj3DSfTDkk
         QD8GvQ8VhOk8OGNyYilBRKQqjzSUYvobJ/h7BbN7YKrhsaLZDLlYHedPYXNsGw/Jc4
         F3QNVVrpF4aDg==
Date:   Fri, 17 Mar 2023 23:23:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     michal.simek@xilinx.com, lizhi.hou@amd.com, brian.xu@amd.com,
        raj.kumar.rampelli@amd.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] dmaengine: xilinx: xdma: Fix some kernel-doc
 comments
Message-ID: <ZBSpCnmDGa+b/PLl@matsya>
References: <20230214010344.5354-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214010344.5354-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-02-23, 09:03, Yang Li wrote:
> Make the description of @xdma_chan to @xchan to silence the warnings:

Applied, thanks

-- 
~Vinod
