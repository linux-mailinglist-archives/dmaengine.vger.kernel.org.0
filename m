Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422584723A7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhLMJW6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 04:22:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53216 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMJW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 04:22:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BC22CE0E5C;
        Mon, 13 Dec 2021 09:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE15BC00446;
        Mon, 13 Dec 2021 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639387374;
        bh=pJatBZj2GLc3qwVUTy3IIbzE0sicO7Iu9WxvVluNMFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lpdho40v56g3QumMljxLA56S0rbTHKy7/VfVTW0/Q3jzsCM78zbe+fr1kKsK/538G
         aGvZeD1yl4zihuPS+IKsgWEGcRgtL9xqlw15r9Weq6g9msx9POZ2yDlAiS00Vt2HkT
         Db2Ep3rzkjiK97ukHGVM70CP1xMfmnZMecKdRqiBqoHa1jO3hg2GBbfz/UWnUwayx9
         YXGTRlwN/e63UJvyO1SisL/8Riox4HbqXtzNuzhN6TnbtF05O5lkqlunCt8ldwfHDW
         EUtdZlav0Czu/lxOVzHmbhKnmizowgEDGHX+dZTTEnU0sPA2XuSyA12ojhGQ5INZdY
         XpEDCJ2QOeDiw==
Date:   Mon, 13 Dec 2021 14:52:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: Use bitmap_zalloc() when applicable
Message-ID: <YbcQ6pNZ1M4mLIx3@matsya>
References: <3efaf2784424ae3d7411dc47f8b6b03e7bb8c059.1637702701.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efaf2784424ae3d7411dc47f8b6b03e7bb8c059.1637702701.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-11-21, 22:26, Christophe JAILLET wrote:
> 'shdma_slave_used' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.

Applied, thanks

-- 
~Vinod
