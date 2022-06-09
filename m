Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30B54437C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiFIGBM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiFIGBL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F02F657;
        Wed,  8 Jun 2022 23:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A66861D76;
        Thu,  9 Jun 2022 06:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FCBC34114;
        Thu,  9 Jun 2022 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654754469;
        bh=kQqFSHATuB03LPjB8yfIBN0VUsIbccHtC5TImKBM1ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4RPvepGSgKnq9aY+9INeoyPa6OgCfiYh88IG8GMf+3+EiAI/FIih7ktPtV9GVmO+
         +tLCeUDKRRuJU+HrrUK8DAiTsQ+spUoBUbfYaJWAi5hnFQhCp+Gw8x5TPWtTOd+bPY
         goPxK8wyzUgQ5fius2VwpNhcLGqGV0717XIRQuw6TV6uVsSFfSmpT7/AQN+uhD3xtl
         tQ/6P8i5AUfBHbL7vfSsy9SBsmV3s6cGUUA8U+u+anR4j9phhHkKnNAbJbD178nc1q
         VioELjbxPUZVtE6pQ1MNuYakJR/5He3IcIhya+6OTeNB3D3SCpBFvGhdyYhI/IZCiK
         r8XazPG1gzkqA==
Date:   Thu, 9 Jun 2022 11:31:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: ti: Fix refcount leak in
 ti_dra7_xbar_route_allocate
Message-ID: <YqGMn9YxiyFQ6W0v@matsya>
References: <20220605042723.17668-1-linmq006@gmail.com>
 <20220605042723.17668-2-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605042723.17668-2-linmq006@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-06-22, 08:27, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.
> 
> Add missing of_node_put() in to fix this.

Applied both, thanks

-- 
~Vinod
