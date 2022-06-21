Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCF5533F6
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351189AbiFUNsn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350518AbiFUNsm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 09:48:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DC63CB;
        Tue, 21 Jun 2022 06:48:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CE3A68AA6; Tue, 21 Jun 2022 15:48:38 +0200 (CEST)
Date:   Tue, 21 Jun 2022 15:48:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hounschell <markh@compro.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Message-ID: <20220621134837.GA8025@lst.de>
References: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 21, 2022 at 09:43:18AM -0400, Mark Hounschell wrote:
> Revert that commit and all works like normal. This commit breaks user land.

No.  We had that discussion before.  It exposeѕ how broken your out of
tree driver is, which you don't bother to fix despite Robin even taking
the pains to explain you how.
