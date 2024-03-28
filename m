Return-Path: <dmaengine+bounces-1597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC788F852
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66281C236A1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B437719;
	Thu, 28 Mar 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKHmmIQT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0214E1C3;
	Thu, 28 Mar 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609245; cv=none; b=rlW5E9121d5IIv8rMmSP9bMgdpQyzvpc++9dBvvRWkIXY1Tr4XX/zkYtrMqbq6xsxj27rVFs0WtAYDhOUvLjxVNP97nLK53MsAL4FW5ZFEvfzrO+rFIEJf8R3alVW3IMK0IzB9UIQw0/GTvZq6MyzibcFCOeYzdxTH3Ow83nZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609245; c=relaxed/simple;
	bh=79pUduyl7sVdyiBAUu3IXG13G61SWXkcS9QfQ9IVBhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR9EI8xCClSrHJ+JVWhtv5xdrMAoAJlTyXSFMj+5FArttGqiwjSkhlvjd1TQbvFcuNbp1pOnlykfhy1BTNUo/4sgOymUP4Xfbqz1kqFl4RkKO4YyWlg0SvlR8foXVK1JXeSpDIq3qfxDLqKiqs6KzaJ0mPoBunFaPor771kGpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKHmmIQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CA1C43390;
	Thu, 28 Mar 2024 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711609244;
	bh=79pUduyl7sVdyiBAUu3IXG13G61SWXkcS9QfQ9IVBhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKHmmIQTNcpbo3VcTJJCnvOni0Pb2AWVxcUE+/De0JsNWPV2WNmZc5ZNQli4G6mrN
	 7Y9coyB4QKqTEV8BV1gV+JZwuUDj/oyT6sJ1K5lPPhI1W6LBEFkn8etWy8FQapkSas
	 ZSeX7SDPZOEENB5AUiM/EIAKgUeLpIuvEkFa+yoOkui4V1ii0LPtpevT8+ek245eL1
	 rjQK2goLxy+n9WfmaCVzuMJohRoMgisFA+vlpn+9SfcQNe6q3Na0t6I9xsQOY5nnZJ
	 aZf1Y9ZVyccTOfpfsCgzhQ6Q142zthSFGlSKeAYi5zV4yiXflDRlBc49Prp3jva76s
	 FtorsR421CWyw==
Date: Thu, 28 Mar 2024 12:30:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: Add support for audio interleaved transfer
Message-ID: <ZgUVmAKlLV2Oqz9i@matsya>
References: <20240325103731.v1.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325103731.v1.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>

On 25-03-24, 10:37, Sugar Zhang wrote:
> This patch add support for interleaved transfer which used
> for interleaved audio or 2d video data transfer.
> 
> for audio situation, we add 'nump' for number of period frames.

User? also why not use the cyclic api?

> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  include/linux/dmaengine.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 752dbde..5263cde 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -144,6 +144,7 @@ struct data_chunk {
>   *		Otherwise, destination is filled contiguously (icg ignored).
>   *		Ignored if dst_inc is false.
>   * @numf: Number of frames in this template.
> + * @nump: Number of period frames in this template.
>   * @frame_size: Number of chunks in a frame i.e, size of sgl[].
>   * @sgl: Array of {chunk,icg} pairs that make up a frame.
>   */
> @@ -156,6 +157,7 @@ struct dma_interleaved_template {
>  	bool src_sgl;
>  	bool dst_sgl;
>  	size_t numf;
> +	size_t nump;
>  	size_t frame_size;
>  	struct data_chunk sgl[];
>  };
> -- 
> 2.7.4

-- 
~Vinod

