Return-Path: <dmaengine+bounces-8975-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFFyCqELl2lEuAIAu9opvQ
	(envelope-from <dmaengine+bounces-8975-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:09:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED415EED2
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF3873004922
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620433ADB2;
	Thu, 19 Feb 2026 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeIAg3dG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6433B6D2
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506589; cv=none; b=ZY86ZwihY96UbKf7H3Hi8uoc2hNzip4FpyCEPi3e9gR715oTk9oDYBz2a6+8ZcNebyKX4GVn4vDV/OWw0JX5JqiESUczOolu5xd7iccERZEjUwjQchIKaWC5+MUiY7Tym70Ie7eP8cv/OREPhMcySx4cy0gAemLT6kRvRpKYMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506589; c=relaxed/simple;
	bh=79yWENIeJiOI8eu1NM831bIc+LOdWu9bx+B4L/t5N4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hweyAyASUDmzi174eezXrycoEl9TMgDIFezolY9YWprEzPdB0f7eh7zMmxt42umlC1BH7XcuOwURZixk2g9mZkGdBeubFbZ82btIktow0CshcmQol48BIbeAupu+OR9AzDWIc/qfqzBXMV3pVHhsq2Bh9TP+23XHskbfiBrvx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeIAg3dG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so507926a12.3
        for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 05:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771506588; x=1772111388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79yWENIeJiOI8eu1NM831bIc+LOdWu9bx+B4L/t5N4I=;
        b=QeIAg3dG3NxERITpA6hxmYMJEjBmGUq4gt5rIFSnsX54UWmrM97jp9HDJDpnSc7bO6
         YKBheVq/dBkNaEFv/jgwq/X2PRxSf935SjeS6v3VBBqfUjjdMFym9DXdr0qotjAc7Rpg
         4j3KOgQ0Wa4yAkfVmH0tOvou+2XNm852YJ01KVa2JimDxLudmz0DC4VnPG+xBFAjZQcS
         tQH+L5Tm9LfXIynH+M8enIcGAJtVS6OmsVfaD1FajwqOvJZeInwQ/A66TamvymEcUzuZ
         0g4PQBR1xiu+DvMeUkd8NaUAlHwrWdBQI4hQ4ZMYgexYhbB9NWD1WFuIpJFArH6eCXX7
         iYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506588; x=1772111388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79yWENIeJiOI8eu1NM831bIc+LOdWu9bx+B4L/t5N4I=;
        b=iGyfSB7zidcftVh8YVZ5oDZc6AjbxF797ibC/IYZNP0xLkWlQz1K+NYSZ/rqUCcSyP
         hORdrnta9STGdUaOypYI1uJbytxEItJGTjseL+uuZ8O8tnNgB3EV+Z2mDMme927S+wwe
         VMuhf5BVsJ7e/jycHpRFFr11Vjg26t01bKuXI6LNhHfciqbxKv8L8ybzHwG/hoE2Rzhc
         YNGC/39dG2+YMGx0X6EU2xj2ZTZhLyodPP61LiMFeUfxr0hB0lFMohaRJC1JZl1NC8BW
         UBvRr+/QM7lOFs0H3+AP73bpMzcAZ+TzfIUUn3frPHcjerJuXjEvZV7dRYLLgUdki51n
         PUcg==
X-Forwarded-Encrypted: i=1; AJvYcCUSf2aTTq0tZu7l1GgAXKIXAIEnPjFVBIfriZ+Zq6wL2i8RncdvmnItq5jwxJkO1jXNXMijA/o8L1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFSk2miwNbEVkhloMseUozhhDrk1T9Sgcjakozygzw7NZYsrL
	vpClcs+lvyVPsZup6MCB736+DdxxfQbjfouzj8jyPn089bMgU+P3/8bZ
X-Gm-Gg: AZuq6aKte8ll7n3blkF+YPgzWKN6D5e251umiWz+Yk+frosqRVJ+TqQunWerjFEccY8
	gEVgeSzawuDF6oq2W1Ci2gR/lscB5jizWvKWwk9EpUSHeOQSXoxKFp/5fmcDTasL4cAf8PvxI3F
	SnDt0F21jHD+2HHNdhdW1Y2400boZguU68adauRYs3aF8qBq2uggiZsst1Exi4RTXsxPjYgjiA9
	4JPcx0fvfWaY0UT9Vw2UyL3n67YCvM0fXIzkQP+8Z2nYOPiI36L7AG7PrOMEHdvwYF3OIPCQj97
	YQvfMHev5VVnRIKmRjcC+TEiokSjaNXdA/tgrZQDpRQp39pllGlKJMup9mN/3tgq/i1pZz6wR4V
	lTtI2uWnfIe6tWobitdReaQHuD2PZuDZGU8E5Dent6BHITCN0BhxlQMc9brafOXask7MHFzYSiz
	0uD6OVYdbN3MCdMU82JI1IOE7/zp9WQ0BCGN1f/xIuHx/NtI/Z1kwNvchmlNMPNCnSl6edrkoAL
	x/gu9r3SU3Cbh6uT5nMHvo+zR4GVTVaKPJRqEeZjjsfg9+jDSPE/ir/V0Sz4KB3PdP2r0wp3j+3
	OsU3CUQ2LX2YSw==
X-Received: by 2002:a17:90b:5704:b0:356:4c1f:98d4 with SMTP id 98e67ed59e1d1-358890dda32mr4625746a91.13.1771506587903;
        Thu, 19 Feb 2026 05:09:47 -0800 (PST)
Received: from minako.localnet ([2403:581e:d87e:0:739f:50a5:e171:f133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35896ee223dsm1319001a91.2.2026.02.19.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:09:47 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
To: Tejun Heo <tj@kernel.org>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Vinod Koul <vkoul@kernel.org>,
 Pat Somaru <patso@likewhatevs.io>
Cc: Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pat Somaru <patso@likewhatevs.io>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] dma: apple-admac: Convert from tasklet to BH workqueue
Date: Thu, 19 Feb 2026 23:09:41 +1000
Message-ID: <6224644.DvuYhMxLoT@minako>
In-Reply-To: <20260206221143.1261191-1-patso@likewhatevs.io>
References: <20260206221143.1261191-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8975-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcalligeros99@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8ED415EED2
X-Rspamd-Action: no action

Hi all,

On Saturday, 7 February 2026 8:11:43=E2=80=AFam Australian Eastern Standard=
 Time Pat=20
Somaru wrote:
> Convert apple-admac.c from tasklet to BH workqueue

Tested-by: James Calligeros <jcalligeros99@gmail.com>

Regards,
James



