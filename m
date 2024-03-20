Return-Path: <dmaengine+bounces-1449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4028808CC
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 01:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1506E1C2133A
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13B25228;
	Wed, 20 Mar 2024 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LOZ+M+n+"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C61878;
	Wed, 20 Mar 2024 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896208; cv=none; b=E6cL5gb7blc5e1EFOGmKcf6EcvJdAGeUvX6Y7EjfP4FMx/Lans2fO4zW+/LGzsefEdMmjwMeHU7C0Tno+yg6p0EiROvOrtNELOY6oOc+jvrBjsWBlX5QHloRX2DmDpM8v8G98XdAD++ouI2EhCUqrtS/VPY9/o/wt9y1hRDyQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896208; c=relaxed/simple;
	bh=cBvNtlCIJz0mQ1wiU+BNW6PLqSKQz//5s21EJwWXVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX+rNTexBEx75pnhrfPAmxquuWeK4RIFyLJxaOPYQIKtfiNgIRQcHNoAYotFU2lJj8bjW3CVxEkeoI+fTZJdYW0USe+IAorXf8VRG2MNZoGzavkBK20bMTEyDwpX9WUyrFKeqMvlLZDI7lSihx5S4/jXJVaJyXLgSr3lIZhdArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LOZ+M+n+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9f7f+C9GVocg4ZITS/YyxDFMD00SU0dGPjNNS6ezU5g=; b=LOZ+M+n+htfCBh1eE9TsJjKSnP
	v8tT7DIP6JlsICytTER1NdC2867fr9NxBi+1ITnp2VtubIsouVSaq7BZQpr3OqiJ7xjEi3IxLawQV
	k/yEfy1hfW+Fzqp0INOO685j/IBLdjf+bRDwWMV9GH7enMoiL6DyPK+SHp5Q38Ux+2vxjsVJlTNFZ
	lRfoF6PpXJlKlji3mjUmoqr5BQ/+VhWoOZCRzfhWF0K566NYs358RNVF0wE3f6xW3utnl2Y87TTat
	pGVnqj280IN7YQk5lN85pDA+OJ2oIWD+rBbaLhF96VhK7N3+EtruBJmiy0VR3ZtZ0xeCBrpNgarw/
	W4FDxW+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmkG5-0000000EpZ7-2IoN;
	Wed, 20 Mar 2024 00:56:45 +0000
Date: Tue, 19 Mar 2024 17:56:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kelvin Cao <kelvin.cao@microchip.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, logang@deltatee.com,
	George.Ge@microchip.com, christophe.jaillet@wanadoo.fr,
	hch@infradead.org
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <Zfo0Ta9cbD5PEO3g@infradead.org>
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163313.236948-2-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 18, 2024 at 09:33:13AM -0700, Kelvin Cao wrote:
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
> 
> Implement core PCI driver skeleton and DMA engine callbacks.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


