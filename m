Return-Path: <dmaengine+bounces-2134-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA18CBACE
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457131F222A6
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0555775813;
	Wed, 22 May 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A8KY6B1s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="stvDvwBv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xLO+hbK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zlx6hSj+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D426BB33;
	Wed, 22 May 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357121; cv=none; b=n5bEvFct/NNgsmGMWHa3KEPgMqBNH7zaEMViBT3f64FVudZjSWJy3qRhZ7Qe4ktdKj5/uhIB/NROMxZ+EFX64TcX+n7BavCoo6Zlw1Ya/agNW+68HQHXHjZmmXo0Axm9sMczquuLZLwvUW6TAy/XFbBzhBtvhIdAFmTiVHHNk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357121; c=relaxed/simple;
	bh=7rl3MJ2xqObrtTFVmEhG93ja5bgZEDf/8t5zN6tTAgw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABPcGzKfo9nik+p3y37NceF9INzKhKOVVrvPUg9JPRpnFg9wIOyUF2eNfVb4HCpJdHUTlUx4kQcZXSgmTdOcMaaVhg+iYGBgN9kcIwJPzkfMDmAg37hhcwFrPxsOcoVCjGkQlYqiyJ6ydHlkj7CjWN+hQ+MK1ePIjhDVn5Ky414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A8KY6B1s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=stvDvwBv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xLO+hbK7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zlx6hSj+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F13A834B78;
	Wed, 22 May 2024 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716357117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7Vj16TE+7ELY0AackoqSl5lpmUjxZgU0xxRG1lc04=;
	b=A8KY6B1sAPCgaCksqyKludilYHioqAYWa2RNPJf007qew8hG91ZVa7ooPOvsiKxd6tgwdM
	2AEqC0CTUlXvYvstZBuJla5TK6cJrqQrpriOqSVasCwd4+wFmEtpKL+K06I9Li8d4s7T7w
	5jxmN/sZU8dHNDKL2eQcviq0ce38HLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716357117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7Vj16TE+7ELY0AackoqSl5lpmUjxZgU0xxRG1lc04=;
	b=stvDvwBvRE4ShEgkU7CTrGLzoC5mXWO/Uuir21S2sZc4kURkmDbcsZBLcvEcYJdjn1ig5g
	FX10NvNzDSU0OvAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716357115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7Vj16TE+7ELY0AackoqSl5lpmUjxZgU0xxRG1lc04=;
	b=xLO+hbK7dXzUGVm4DInedFvrzXOZ41IVO1nUhE7z2mPzGUZ0PhZdJlT4r1vEBHWG671JFA
	0lvA+nr+s3nwchZupX9CBgW7FdTZNp8SFSLigzRTddSGKvvTCSkhf99XXQumJK5AgnXuXM
	oDFkiZHFSbNZ+pZPRkMdNzeWYgaaMvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716357115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7Vj16TE+7ELY0AackoqSl5lpmUjxZgU0xxRG1lc04=;
	b=Zlx6hSj+1bLyXRLdMnrc7n85ecuPiumwWHZLGvT4BOtIJHK2ojqGYLNcXTCPRWo6lHJnfJ
	KwKZR1pYpOygowBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99761139CB;
	Wed, 22 May 2024 05:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dXOqI/uHTWYZQQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 22 May 2024 05:51:55 +0000
Date: Wed, 22 May 2024 07:52:14 +0200
Message-ID: <87msoiz94h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org,
	alsa-devel@alsa-project.org,
	miquel.raynal@bootlin.com,
	perex@perex.cz,
	tiwai@suse.com,
	lars@metafoo.de,
	lgirdwood@gmail.com
Subject: Re: DMA Transfer Synchronization Issue in Out-of-Tree Sound Card Driver
In-Reply-To: <6e01c13f-2bc1-4e08-b50e-9f1307bda92d@sirena.org.uk>
References: <Zkxb0FTzW6wlnYYO@localhost.localdomain>
	<6e01c13f-2bc1-4e08-b50e-9f1307bda92d@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.24 / 50.00];
	BAYES_HAM(-2.94)[99.75%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,alsa-project.org,bootlin.com,perex.cz,suse.com,metafoo.de,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.24
X-Spam-Flag: NO

On Tue, 21 May 2024 20:32:59 +0200,
Mark Brown wrote:
> 
> On Tue, May 21, 2024 at 10:31:12AM +0200, Louis Chauvet wrote:
> 
> > To address this DMA issue, I have created a patch [1] that guarantees the 
> > completion of the DMA transfer upon the return of xdma_synchronize. This 
> > means xdma_synchronize now sleeps, but looking at other drivers around it 
> > appears expected to be able to do so.
> 
> You need to set the nonatomic flag for the PCM to allow this, the
> default is that triggers run in atomic context.

Right, that's a most straightforward solution.  It implies that the
period updates must be in non-atomic, i.e. use a threaded irq handler
in most cases.

If the synchronization is needed for assuring the hardware stop, there
is an alternative with PCM sync_stop callback, too.  The callback is
called at each time after a stream gets stopped before the next action
(that is, either prepare, hw_params or close).  It's only for
stopping, and there is no similar way for sync of a stream start,
though.


thanks,

Takashi

