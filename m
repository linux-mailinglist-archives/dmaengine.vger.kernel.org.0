Return-Path: <dmaengine+bounces-974-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F73484C888
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604371C24E6B
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC6925566;
	Wed,  7 Feb 2024 10:24:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615D2555B;
	Wed,  7 Feb 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301451; cv=none; b=kAItNqp4A2y2vMd/pI1JNQNL2X2K02vIkqkrDNFBtxdpxVZsOGzxGGC9AxnoEDnpycekpZN2E0dVRtxzgF6zUUOK0WGDthljASqEqI6dHXtR7l/785R1M/8FIM9vf9c9Z/eNqL9NAumianJBdjXO/qr3aOX4iA4iyQV7RHj1heM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301451; c=relaxed/simple;
	bh=1u844JdOspud4W4+APo/b2az/45qjV4OlJvotpw9ZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw9eimL1BLpGeh3WgIovRYFKd6QRSvuC/x2Pla6ZIym2MWgbNMm7knNKRy5k9Dv3FvWhadhuHm2NgeSj9WnwyVayAfwRRnMoMnDYhiPgwGnmqQyVRBpUdtXQgAYoKJHFGU+3dTjJYqG7HUM4ZqXbTc5nnKDuQpNbHWVuEaxkegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA52321F44;
	Wed,  7 Feb 2024 10:24:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A18413A41;
	Wed,  7 Feb 2024 10:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CXtbG0daw2V7XwAAD6G6ig
	(envelope-from <aporta@suse.de>); Wed, 07 Feb 2024 10:24:07 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: vkoul@kernel.org
Cc: andrea.porta@suse.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	florian.fainelli@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	maxime@cerno.tech,
	phil@raspberrypi.com,
	popcornmix@gmail.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Subject: Re: [PATCH 00/12] Add support for BCM2712 DMA engine
Date: Wed,  7 Feb 2024 11:24:06 +0100
Message-ID: <20240207102406.6672-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZcM9I-U3w7xRcWVt@matsya>
References: <ZcM9I-U3w7xRcWVt@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[33.55%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,broadcom.com,vger.kernel.org,lists.infradead.org,cerno.tech,raspberrypi.com,gmail.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *****
X-Spam-Score: 5.30
X-Spam-Flag: NO

I was utterly inclined to unify all tags, then I realized that
could be simpler for anyone working on it to be able to grep
the patch subjects as they are for an easier mapping to the commit
from the vendor tree. But I see the point and I agree with you, so 
the next series version will have 'dmaengine: bcm2835:'.

Thanks

