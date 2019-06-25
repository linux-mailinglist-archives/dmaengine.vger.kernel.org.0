Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D4521E2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFYEXI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYEXI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:23:08 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7946A20656;
        Tue, 25 Jun 2019 04:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561436587;
        bh=g8R5D05SwKQ/XjeNXsPC9J7BSXUsfkuivSbwg4q4NZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYvC5dxsJ23hoTCkZTiRGFIxBQ9YNYhXofBwb3niiPvgiliFIfs8WggaGaAn1DovP
         I+X+cxtQSblri14bQCNATdChWkV7jCwUwuE7ofs6lxZx2anF6DNd2PVbnP34QZXIzY
         aoGYTlWWfauBFDc5CbKwMx94NGStHhB+NEuaZh+k=
Date:   Tue, 25 Jun 2019 09:49:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: dmatest: timeout value of -1 should
 specify infinite wait
Message-ID: <20190625041957.GG2962@vkoul-mobl>
References: <156089501718.8121.12070116684408969349.stgit@taos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156089501718.8121.12070116684408969349.stgit@taos>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-19, 22:03, Hook, Gary wrote:
> The dmatest module parameter 'timeout' is documented as accepting a
> -1 to mean "infinite timeout". Howver, an infinite timeout is not

typo Howver

> advised, nor possible since the module parameter is an unsigned int,
> which won't accept a negative value. Change the parameter
> comment to reflect current behavior, which allows values from 0 up to
> 4294967295 (0xFFFFFFFF).

Applied after fixing typo, thanks
-- 
~Vinod
