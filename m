Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFB04FF6AD
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiDMM1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDMM1V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 08:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96752E6D;
        Wed, 13 Apr 2022 05:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF52B823ED;
        Wed, 13 Apr 2022 12:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A11C385A4;
        Wed, 13 Apr 2022 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649852698;
        bh=usSiTOLYEoHwXftqbxUG2VVFK4p83txsv4K+IrKM5YM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Jcjp3TKJA9LcgSZTL2gIo+MyEpqgc7zyCuwHjWYVI+i9FkUEcpZ/M6l4JlSPUBwUv
         MXcCio6g+pitlmWo+I/2sWAD5b9pOHU4lZ3anPR7fgQ0m0F4ELjJVbjx0R6qjBduhA
         NVHjyv69tsnW7Cm28Z7XoWNsoUHbZFpuCBs5M+j3/JlRMM1WKunTP6M+pnN424s6QU
         dbsokjKBwnvcsFBD0LIr870IcsYUa6usxGN8cfqbr7sHekwQ89AzHXwhhywI/zMnOG
         bR4QHH6CDuDKjc8aUaYWtXZ7WA3oCUept1JE3r3GePXHNJhlROWX21lZFo7qMEV1Fg
         bKxX1TFNsIgSg==
Date:   Wed, 13 Apr 2022 17:54:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: qcom: gpi: set chain and link flag for
 duplex
Message-ID: <YlbBFigW0tusYsfQ@matsya>
References: <20220406132508.1029348-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406132508.1029348-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-04-22, 18:55, Vinod Koul wrote:
> Newer platforms seem to have strict requirement for TRE flags which
> causes transaction to timeout. This was resolved to missing chain and
> link flag for duplex spi transaction.
> 
> So add these two flags.

Applied all, thanks

-- 
~Vinod
