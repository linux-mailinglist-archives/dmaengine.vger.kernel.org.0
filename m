Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA904D5BE2
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiCKHEN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 02:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiCKHEN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 02:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6013F53;
        Thu, 10 Mar 2022 23:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 083C8B828A1;
        Fri, 11 Mar 2022 07:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30438C340E9;
        Fri, 11 Mar 2022 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646982187;
        bh=zo3aBJFcO30JWZqIydxPZlNDKixspfDGWo9Vc+kxfrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xesji92rSNSRvpFN42bEMBKwy/jrIbwLMigRlqhUwnLEtmACCi41wta82ypHVuiWG
         dotq1V4GsNnXrvravyL9+nph1XVGYilGkTIp7Nc7uYQWEtkwX0GLr8w7JeKcjsdvsX
         TGhUG/DdZYzp5p19axEFMaiiJNE2VYDgLSB1DaOqkdc1Cu9ozZxt6EjQnzCtC3OYMz
         rdDh9M6LVWq0PoF9RvewPscP6NGBpUbKKz556Rd6sTY7xzjqjTD8xtxbUxKUX1ebX+
         eU/SfCMfjq2Y9+FcyJScz+d1o4o4DMPJYSXrZuoMafD7DnRo4dJ7wCvDJlFBNf4Tai
         HWHXzEVRVh0bQ==
Date:   Fri, 11 Mar 2022 12:33:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Add support for AM62x SoC
Message-ID: <Yir0Jwmwdwd92X7n@matsya>
References: <20220219083220.489420-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219083220.489420-1-vigneshr@ti.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-02-22, 14:02, Vignesh Raghavendra wrote:
> Add AM62x SoC specific data for k3-udma driver
> 
> TRM: https://www.ti.com/lit/pdf/spruiv7

Applied, thanks

-- 
~Vinod
