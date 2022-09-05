Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C355ACA88
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiIEGYF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIEGYD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:24:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32272B261
        for <dmaengine@vger.kernel.org>; Sun,  4 Sep 2022 23:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 321ADCE0A0E
        for <dmaengine@vger.kernel.org>; Mon,  5 Sep 2022 06:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11284C433D7;
        Mon,  5 Sep 2022 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359039;
        bh=rZrUIv+Wt6dtj2oFuy9UHXEuSWo+4Gw/SYveaBU6GLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aePtF9YkwLL5lUJ4+e41QAS6AwPZguTS1lE8OyVV31JrnFozgJ+DM1JHnxa/xaisI
         Mz+70Bdl3WJEc2E7LqPXca4FazaHOtz6dyiNV/ue90TWF6Pv/0vZISgjt3k/zEZqZr
         7hGBBrPSV81iwjDr/Gwnsg50xHa/UY1MeHUK3/9nltRKifd4KfPd+v4lMQFUdBlzLf
         fZYSj/AlXny9H3+JOxagTX1ABGm0MqoPFSrZBjHI5Y+Q8inRrYbyDXrKcYRzJN5GSh
         00O8akmCnGo2aMGi+CG5DjBhnHGQlT2J+XlSfToH0bmGZiPua7JqxmuOgD2r7raX41
         IsKfGkXWigH3g==
Date:   Mon, 5 Sep 2022 11:53:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma-private: Fix refcount leak bug
 in  of_xudma_dev_get()
Message-ID: <YxWV+lstMwYm+krr@matsya>
References: <20220720073234.1255474-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720073234.1255474-1-windhl@126.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-22, 15:32, Liang He wrote:
> We should call of_node_put() for the reference returned by
> of_parse_phandle() in fail path or when it is not used anymore.
> Here we only need to move the of_node_put() before the check.

Applied, thanks

-- 
~Vinod
