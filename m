Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D44FBDCF
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbiDKNzN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbiDKNzL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 09:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A822A;
        Mon, 11 Apr 2022 06:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C098B61188;
        Mon, 11 Apr 2022 13:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFD2C385A4;
        Mon, 11 Apr 2022 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649685176;
        bh=COQ1PBqnPhA/PE8lGRohDqW554kdrzmL8XbqfPazdBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qja5LxzLF3ws3+7Bww3sfCpj6sp0WTcqCeFEm4W1Y90BsAyehQj39P5uH7hZmL6G1
         Pd1ouVwjtAxSAd5cJeLY++7V8non7T5woYBtd2Lc/Ov5lfPBOIhq9hhEhJJ0p89uJg
         PmYe8s8UPeMZTzsgosmQ7K047TWq3dmbfxFfEsTlMMeC1DPbMMc7D3AhrG5OaFBWN6
         k/H5OccR5sMgOOm+VBBs1xISpooYYSxJhB9DtoH9B5cZNdVNOzayyelCRVNAzMZg6N
         AnEYafnHNINr8/XxvXg5Y5eV2ayPgkfLxpM/yI4/jXvKvptlBmHzPxzg2FoD+983X5
         bL83mjWuUOT2Q==
Date:   Mon, 11 Apr 2022 19:22:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Stefan Roese <sr@denx.de>, Rob Herring <robh+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: update my email address
Message-ID: <YlQyswVRsHVGRjpn@matsya>
References: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-03-22, 18:56, Olivier Dautricourt wrote:
> This email should now be used to contact me.

Applied both, thanks

-- 
~Vinod
