Return-Path: <dmaengine+bounces-955-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F568497B7
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93361C226DF
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF9168CD;
	Mon,  5 Feb 2024 10:25:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BE16436;
	Mon,  5 Feb 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128711; cv=none; b=XkXgvVEw+ViGMEqF/w3bh4MUV/A/YlSMZYNKD+j+Rrq2dh5IYOp1YlzIrZfvviU/+GWQDgFWcPwZY38yMKAePrR5EsHZUWVkkSWSBk1sm5MNAztlSI7PIxXwfPuZL+KX7XcC8dE1WyMxOl55MJ2ZQ8xqFqAWQZ/PrkZscAhhsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128711; c=relaxed/simple;
	bh=ivo3TXLyfqZY03CFtOPd2ttNNvE/OP+/puwD5Z1Q6tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/oEPCzFZuuj4pzou+Eys7LaEWdeDgIBJYLSYpMq9o2/sQxNhjwbqiE9PlS37CfqqJ1WxnLtJ0hk0fP3Q/IiUBpXxELzO04rdV4iD5B83zkKhZPMnRaRPucBnlSxEPJ5Anf7ElV9/W+UutvT/nX+lh8fwVnumwxkZyb48O8oc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 698441F8BA;
	Mon,  5 Feb 2024 10:25:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A659132DD;
	Mon,  5 Feb 2024 10:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R0sLEIO3wGWMLQAAD6G6ig
	(envelope-from <aporta@suse.de>); Mon, 05 Feb 2024 10:25:07 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: florian.fainelli@broadcom.com
Cc: andrea.porta@suse.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	maxime@cerno.tech,
	phil@raspberrypi.com,
	popcornmix@gmail.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	vkoul@kernel.org
Subject: Re: [PATCH 06/12] dmaengine: bcm2835: Use to_bcm2711_cbaddr where relevant
Date: Mon,  5 Feb 2024 11:25:06 +0100
Message-ID: <20240205102506.30039-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <04fa6114-3394-4e1e-84b8-9552f3ec398d@broadcom.com>
References: <04fa6114-3394-4e1e-84b8-9552f3ec398d@broadcom.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=none
X-Spamd-Result: default: False [4.55 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 BAYES_HAM(-2.94)[99.75%];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,broadcom.com,vger.kernel.org,lists.infradead.org,cerno.tech,raspberrypi.com,gmail.com,kernel.org];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.55
X-Rspamd-Queue-Id: 698441F8BA
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

>> From: Maxime Ripard <maxime@cerno.tech>
>> 
>> bcm2711_dma40_memcpy has some code strictly equivalent to the
>> to_bcm2711_cbaddr() function. Let's use it instead.
>> 
>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

>Where is the full patch series?

Hi Florian,
sorry, what do you mean with 'where is the full patch series', exactly?

