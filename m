Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61717458890
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 05:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhKVERy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Nov 2021 23:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhKVERy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Nov 2021 23:17:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63E1E606A5;
        Mon, 22 Nov 2021 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637554488;
        bh=YNn4+8WDKdGZ8O44BogasOLlwHLNvIIYf1h2THEU4a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjOF/MztR8BScLqSpiXQw+VaHTKIq3bqKUJfQlJ9fBY7fYdXHC0Q7KPLT5DFxK5FK
         ySi0iA4wOsAWuT3F0y0DM97WihsQScXkoLiLaYoAAIaZF07SA5SdarFjj0mXH9XVoz
         DcNpyzmWGNo7sSlHBS6V2UFqBbDUekYt2aDXV/6bsUaTRDYrpejGOjeyQjYhIX0pe0
         RovhvPo+fnITvDCLuLecl5b6K6+OOW+lq9zm8zfH9C6IVy3fljyN4E8IAODGG/9E0U
         4c+eP+BcChDXSp8J6K0V/WJaojAOK//zHFeaNysTEYfb9VefSPJra+uq4u6OqAE2oQ
         DXkjtni1VNwHA==
Date:   Mon, 22 Nov 2021 09:44:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: compile error for 5.15.4
Message-ID: <YZsZM/FqwJTqqJfj@matsya>
References: <747802b9-6c5d-cdb5-66e2-05b820f5213c@gmx.de>
 <YZp6yfVUx4eEwaxm@matsya>
 <fda4aa94-22d9-b54c-2bde-b91a579af802@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda4aa94-22d9-b54c-2bde-b91a579af802@gmx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-11-21, 18:18, Toralf Förster wrote:
> On 11/21/21 17:58, Vinod Koul wrote:
> > Can you please send your config file when you saw this, which toolchain
> > was used to compile...
> > 
> > Thanks
> sure,

This is fixed by:
b3b180e73540 ("dmaengine: remove debugfs #ifdef")

Pls confirm by cherry-picking. I will send this fix to stable.

-- 
~Vinod
