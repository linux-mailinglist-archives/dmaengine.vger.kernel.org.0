Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17248941A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiAJIre (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 03:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbiAJIqw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 03:46:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50379C06175E;
        Mon, 10 Jan 2022 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=DsdAsFEY1Sw1iBcxRCpFefRdWy
        6H1ziM7DGPLkXrFHPDFLutYo/kcxNKh3y3xgIbnyhoZO6nMk6SX/LLG0Y/vh98+dHnGBg60cKfevZ
        ZpbhcIlujoDKfXePeWlW3ZUlMiDqonjDtYmVZKpFQnWe+WZ2wJ/nUwgk7lARf//mGLVqgMI74Y4uW
        TDtL/Joby/9QkSAL6P6sD3/TZkXaue329YzFNQOfbf8Xnw5zRV5Uvza0yBsdev3kgXRmopYtbym1G
        0AJR2P73k9hPlidbM6uCHz6q+F0xhjGvRyd0Ou2P7c6qGaXAH/x1nNqaMuJ5f2ylaY8c5/BCXJTs1
        YRTuI8sA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qJP-00A0Sh-2D; Mon, 10 Jan 2022 08:45:55 +0000
Date:   Mon, 10 Jan 2022 00:45:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 07/16] dmaengine: pch_dma: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvyQzrD0kBTGrvk@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <b88f25f3d07be92dd75494dc129a85619afb1366.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88f25f3d07be92dd75494dc129a85619afb1366.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
