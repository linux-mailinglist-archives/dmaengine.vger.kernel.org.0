Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D543B002
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfFJHyR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 03:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbfFJHyR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 03:54:17 -0400
Received: from localhost (unknown [122.178.227.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFB2F20833;
        Mon, 10 Jun 2019 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560153256;
        bh=P4DGh8ttH28T2p9/JtWa0sqscD/hKoDboB2sWHg32nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRZLtn+6g/Wx35xTU9bTm8tbIZcDe8OC5CIkMAgTIB60WF78fjy7t2T3psBUDNJ23
         4lCm8x3vEzpZjNw43v0hh8QQE3JXHCo39BE6Awa91LzeU2+u5vyDrJoWICcHymQZIC
         mNTpnpdprFzD/BZKdD7VEPGl6cIwBPyVkObPB8Zc=
Date:   Mon, 10 Jun 2019 13:21:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jiri Kosina <trivial@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] dmaengine: Grammar s/the its/its/, s/need/needs/
Message-ID: <20190610075108.GO9160@vkoul-mobl.Dlink>
References: <20190607113039.14560-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607113039.14560-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-19, 13:30, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks

-- 
~Vinod
