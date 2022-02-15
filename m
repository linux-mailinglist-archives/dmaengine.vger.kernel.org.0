Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F44B6258
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiBOFSR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:18:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiBOFSR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E30985A3;
        Mon, 14 Feb 2022 21:18:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33F52B817B0;
        Tue, 15 Feb 2022 05:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D1CC340EC;
        Tue, 15 Feb 2022 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902285;
        bh=B0dV72SpkaC/hqg3i0PzRzrQESYJvg5LGjbZQ2GyHeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsNPRCay2L2EBDCGdxGRUbPZ8RNfMcxDib1LtwRy3xmJodn/cxNE8K7Fki3O0JeHs
         y21gl3Lseg5Npewt/pgHL2qNGyuA4lIz2qAvsr6sQeniO+uhirk2+LSGRxFK1g2s6j
         Hfmv4RDHMwlESivxfZlS9uuOc3C69LlDG1oiRzyGxeP/x2DMjg6MCXFePre2QmGpF6
         Qp83riXkr9ZhqKwNMEV32wziklR9rqrrY0JFxiVapv0JHWo2YP0KGiO53CwZwU3xn8
         shV9nVUEo23Q/a6lp+nN5gBFu3oWTX+KFHkLzt9YRewVYypDE1NbToSWf8dtv/tPL2
         Yr9gl2awttn7A==
Date:   Tue, 15 Feb 2022 10:48:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
Message-ID: <Ygs3iKOUmCa+HtJp@matsya>
References: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-02-22, 07:58, Christophe JAILLET wrote:
> In order to free resources correctly in the error handling path of
> pt_core_init(), 2 goto's have to be switched. Otherwise, some resources
> will leak and we will try to release things that have not been allocated
> yet.
> 
> Also move a dev_err() to a place where it is more meaningful.

Applied, thanks

-- 
~Vinod
