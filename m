Return-Path: <dmaengine+bounces-10113-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK9tKIN562npNAAAu9opvQ
	(envelope-from <dmaengine+bounces-10113-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 16:09:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E2460030
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C60923013271
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CB3DBD52;
	Fri, 24 Apr 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA+tJZge"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842B3DB65D
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039634; cv=pass; b=bFhXHrXVuOArK5JM8xtutD596ooDTllBeOoSmBFoABaO2D71mc8kCwXLBgeeaNt/k1PErpBixjW/hUjrIzJ6qn+rsqQWWs4eMMOWWh5kFAjLA/RpDWE6vHRpc9au4X/HtvAOdwrvcCaQiLLpYsnuUd4S+z9H+HH4y3/w8DSbJwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039634; c=relaxed/simple;
	bh=0vHNbcS1e0SAERK945k5arjZYG5I6f9wxmg4vz9z62M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UU2WuCHYWY/bIppCCCzzIH94KTkdw5BB+HNc0vJjKWdTWvCvpAUsnnM4mjvK+maDSPdzEzMYsv54jkjB9+IBWNkYCuHmqbzJ+D29hb/im8J+kZlT+uEzST2NwsWCLQ6CV3r50hD2j53L5Pz6D666b1m25QUK/GPYSMi5NHRRVYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA+tJZge; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797ab169454so96566917b3.3
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 07:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777039631; cv=none;
        d=google.com; s=arc-20240605;
        b=UeRNR0+Ocx2ngJiHM6ievdLEpRBm3kbNZusYVwYyM+33+HIjKeztZDo1t3zHltTDrm
         mm2j2mCugg7ZOajlD25qUtIwFrOe1vlsY+orFlI2nzJEXT8eKzfFHgdiFilDd15/1b/g
         pZkU3m2uAgiuuOG1bq1hFpSLohT/x3KIbwh2xw47G+FUAbDendENlH/zs+EzVkKnV9ag
         421qNv/KBybBQdEi0RpYmp3glW1BBOaFcFriuz+fKenEWbMxJV3h/ATyU78NGNMSd2tw
         MDd2+iL3FN6YZQDbb6wB6SeqJZK5UuPMD7oah2Wem8VdfwZqjJ3r7M8q6vde3mAmPWSm
         wiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/WQ0pfrwBxYVymIPR3X+ZdARYJYIEk1Z7v+Y0rKrVts=;
        fh=U/iNhmSmqEUyx/Di/PeaKN+Fv0e6T+ekEQMqLbCas+M=;
        b=J9WWlG5n5eNrhaxznN6Mvip064NJWUtmHjvHZVqQoZu86NZUWdLy+4MDg4ylDLybIx
         spLJjFyYJWmdieChE8DicGR2IMy3/oW5ZXUn3T6BxRpueKvql9SLdLGJZ1jS96swJ0+c
         7q3wQ/Nsw8LUQB/Xcew+3BtoIgRo2C77jyv8sHxa2DrPxc0Ta4Jlb5F8RHqBVvdmFSLH
         9mLiOLXpJmMHSkRZecKwcp4WO+swX/uNLkKxJjtkBinAviOBZ+8Ed/mjB3hzSqN9pyRL
         SriMsXxU4INAfY1uKEVbdv+br9snf7y/4tYM4v9ZUsEqHijZErkCZbJihGctjSfI0Lq5
         sRBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039631; x=1777644431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WQ0pfrwBxYVymIPR3X+ZdARYJYIEk1Z7v+Y0rKrVts=;
        b=iA+tJZgeBLpCJ8vSPO+ySjsvfhqbYK3H71dicvyYRc1gbszt5GxP32o9t2+8y3rbq7
         j+bzyGqu4sHrQZ2IcBIzzvTMXPUtEM3XAJeMY13ECSWDSc0Y2LlOIflo5w+t5Vuo8+yv
         tVsnZOwHmG+5sD8R/YvVbpCK3Cbhibo4zdXAeUdD2t9cNljjSBcRuVosqaISXAJXP1u/
         AJW38u+9EYnYjs68hbE/8hHSg4/BY4d9Hyrw/BztPFAg1LGsi6UMWq241GWUUuj+d67r
         GWr7YRhuc+1uj5WIaygifVmbo8hSHkkZ6vr+fQuNwVJLb8FCXdZfmRATh+Kc7QTa+/ZL
         EDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039631; x=1777644431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WQ0pfrwBxYVymIPR3X+ZdARYJYIEk1Z7v+Y0rKrVts=;
        b=TwkSBjlhcCX8croYdzHKgeiW5ATQX1xXb8OJsnAio+oV865ouX80SCup+/VoRJY0Xx
         laECFXlNpmPesOJCDBjS23Tkc0RFWBUtmnP/Gq2GPf8Bqk6axYXvoHI3GVfwCT+oQJLY
         QID2MpRxNumInxbN/R3wXmfumqo+riUecoBOGxtl6pN+2YmeRG+s/EA5AjrtjkX0dFmH
         AsSWNEud6Z/yZoi3FVAT+wrIer2R7LdIxmGUpBfLwNXhAxxwcdelTBV/rN5WJ2ZuSFsm
         KIccFrgGKqP2nZB+voUjiAhhb2y/capAli1VCCDm5tx/TJ9m2ftMJ2t/5cWRSWzivUeK
         75aA==
X-Gm-Message-State: AOJu0YwPx7OU4mHglJ8FhUX8JXjLyobMtMdelcGMLm7YvIy28rM7Ghcd
	FO1NNCh4Gw2BEmxaRAByvl9woYeYM4mdJAMO61Ry/ClqkBPDPD9OzDBvnNVOEgepgtmyBq3RZI2
	3vRKLir2qvjuovQ/UHqPkhb245/28wRE=
X-Gm-Gg: AeBDieuM2w38D+/vxHXxjfEC/V0RtvCJ7g8772K7DIrua5oTRYYuVELXIlTaZmAgCsV
	ly9CJs6JumgJcrrPPk5a2cRfGfLkux2SWq//MKVIszPESh9hQw7MaKBmjtXZo9IteLK4MYGRr3v
	CmPoFiaAlQP3qIuczkdhBG6x0Kd+8ZK2N+fKg/0pujj3gf05om4eKU8125UZWShmIsLJVAgeN5b
	SIe73sHB8xqlsvSQ+VyMdMyafbVictY9tbfrOisbbRK6lA8BNkJRcPyyedl0SjQ0bY0LlQ/HfAv
	/e1vhgdP4Qt+oIk0jw==
X-Received: by 2002:a05:690c:a05c:b0:79a:6fa2:8129 with SMTP id
 00721157ae682-7b9ece7afaamr270592367b3.6.1777039630964; Fri, 24 Apr 2026
 07:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 22:06:59 +0800
X-Gm-Features: AQROBzCovnbm38AvDOVsmst2_tsfJbIxedwEamlEljp7htpK_KUYZMnA9h7fJrg
Message-ID: <CAGp+u1ZX5Y9V7pW2x6HzVShJ7D0HnY42VSKsLSibWu-W6RHcrg@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in 'drivers/dma/milbeaut-hdmac.c',
 between 'milbeaut_xdmac_interrupt()' and 'milbeaut_hdmac_chan_config()'
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 034E2460030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10113-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/dma/' subsystem, more specifically, in
'drivers/dma/milbeaut-hdmac.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
milbeaut_xdmac_interrupt [t1]
       --> spin_lock(&mc->vc.lock);

T1:
milbeaut_hdmac_chan_config
    --> spin_lock(&mc->vc.lock); [t0]

T1 can run in normal process context and does not disable hardware
irqs in acquiring the spin lock. If T0 (i.e., running the hard irq
context) occurs after T1 acquires the lock and both happen within the
same CPU, then T0 will not proceed because it cannot hold the spin
lock that has already been possessed by T1, yet T1 cannot proceed
because the hard irq runs disables preempts.

Thank you for your time and consideration.

Sincerely,
Ginger

