Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6166D2AEDF
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0GnH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0GnH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:43:07 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4CD20717;
        Mon, 27 May 2019 06:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558939386;
        bh=gyLqhVIAkj4PBMbVcc0X9M/enzefZ96sSBNlv98yeks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg+sRuGc6Ky4Jl+fG2LhCGGpkoz0sQG/2vdODooT/gDAg+tYmXcbEwPO5RuYUPT9Y
         4dN6slql8O5VZEdQMtFRlAkUtM6eo4Hh//ZANQaiIvbXInxBwpse3F9IL7fFT1VAl6
         LodFA0Onl6KZtMwtohs+6ssdM6XCDAJ7D1EZ3akY=
Date:   Mon, 27 May 2019 12:13:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     dan.j.williams@intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: use to_platform_device()
Message-ID: <20190527064303.GG15118@vkoul-mobl>
References: <20190526071324.15307-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526071324.15307-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-05-19, 15:13, Weitao Hou wrote:
> Use to_platform_device() instead of open-coding it.

Applied after adding stm32 driver tag, thanks

-- 
~Vinod
