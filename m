Return-Path: <dmaengine+bounces-9651-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P/8GQ/yw2lZvAQAu9opvQ
	(envelope-from <dmaengine+bounces-9651-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 15:32:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6941326CF5
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98D0E3101D93
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3843DFC6C;
	Wed, 25 Mar 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1q5nmKA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DE344DB9
	for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448595; cv=none; b=pb7OmxOcdsjWUdTiUFQCRtKoe2kcrYP4ICohy2QDegh9wXegR7cF97AQQWhYqyeIFi4pm8qPlp3/84wAZfYuhHBIfoD8GgZrmj5pKi992YdsCHl+OVgoUSGyvda5dHB2JvPrvqnzdynn7qI28V3V0YFM9eS7RkbNFIuq89eYmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448595; c=relaxed/simple;
	bh=EUZRaRSoeGbeHMPN/xeMz+gDo6IrLpv59F7gq0WwPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0yo2aTcm7JtQ3YfPXxu1QoBMSFvk2CjoPFqVhvl5gazJ4F2mFtc/CNo+fhc6q0UZ4eBHalCsd2Pi1nvbuZm1y+agctAH8RksuihSkYH5T11j/IhF6XXnIgS2WYpT+V1dr35UFkRliePxVBSS4lMCyXV47mv/QYIloXZ2HC76Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1q5nmKA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2adbfab4501so22869655ad.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2026 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774448594; x=1775053394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUZRaRSoeGbeHMPN/xeMz+gDo6IrLpv59F7gq0WwPeI=;
        b=X1q5nmKACq6NltiD14osi1IeoVF4GELCT7mKDhiJ63Az+5Y/O2/SQmuM/9ST4seBGm
         Nj/PTTSU0rl7BAcahG8ivU1yt/FQe3ipgFW3h323I+Cj/brSBTIJlce5lL40NKXyYXba
         su0oNgtE16ck5/P55GrgrMzfWCepZxJNK1gSBcyPpP+uE6dEWQMqvNRhTwXRkerjn1mV
         gfsiAuFxrl8aB3tyLJFm/NM6r7zXN+/K1q7OYJp4i9IQTInPFwAej9xgl7UgVSp+rhfI
         XjltS3Tdc+s/79avwLzNsNXvLzoAaEuip9Qx6ovnzAIUPXZ1GHMRm+t8cl80A3HR5CP6
         cu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774448594; x=1775053394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUZRaRSoeGbeHMPN/xeMz+gDo6IrLpv59F7gq0WwPeI=;
        b=cK/fUTXYFn+XlAcGzx2hQ/f/XTdJ3Oq5QmIcikj4xuvQksd6nguiBS7fzP7e27Nh4+
         7WEF+YQhC+CQ9xFk1Mj3w6ChQ34wL2x4mvXOoWZC+41+hKqdC2oXMddrqIXrFXgeyt6t
         Ikh3mafgMgpiyW5O+gJtVg2GNx2WxAKhP3jAIp7ftonCjmxAMaiRiCyIKS2exh+D5G+N
         Hyx+KXYdrnTFa/qnL/BzuhuG0bjFwi3nBs8JneBqbuA0R/VLE5DCqa8e+x/FXtvw6kPR
         0Up2IwZfifnVhfI5wAuuFPalJ1NFyW5vdes6ufaY2sym5iKBZLQxzl9PB3vGrL4tIzjl
         N3WA==
X-Gm-Message-State: AOJu0YywTJS5iL/LJ1cX8/S1VcA9GI4m2TMPoSR4dKTKwavBhe8kckqu
	wd6acje4qNtSeF0OMNIEl8Rm+10y5fKhFENKll2FcM02C79aRtVMNzvs0gGui4iD
X-Gm-Gg: ATEYQzxe0Amit9/zpB3YQkCCT86ni2hLxgyTvr6fI9UX8FqCzEmyaY02uwPZ0f9rah9
	lAZL+aiOc4ChiDF97qQtvN8MW59t4Sb8fHUtibVG52mgcUPauZTFAiCtoaO2anZeOdnzjIb2nYk
	LnRzdvSjDTRxor7E+5QN7NpPlIZge6Uvz1li7dSeC+0jQgINvnR9SpS/i3TEQXd4UDiwSacA2vv
	Tg6C9mBKABZpU8/T/JdU8qUkuJBk9B1NJ4M4VO+YCuFCLwKqr4VhnpjEjVHzNztRUEjyKWTixs0
	nLDFOIngd6bBNrar7GfHMiR8gdsGdSHVTQt8ksvmlpJPXfb9xCSp4TdoMVaRPbvp6eSvZNFjYAD
	fEPzSy1blzoMaeMmdiVKRDEaVBYsTDMqa5RYIkXJWSscUnm/d83krjcZyIqdqVAFchZ9q913m4w
	e6HFUACoUv+mNEOQwutx0xpgY=
X-Received: by 2002:a17:902:da88:b0:2ae:504c:ae8a with SMTP id d9443c01a7336-2b0b09d55bfmr42098335ad.16.1774448593427;
        Wed, 25 Mar 2026 07:23:13 -0700 (PDT)
Received: from bsp.. ([2401:4900:5034:e673:1f10:d599:388e:a85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b8adasm860705ad.33.2026.03.25.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 07:23:12 -0700 (PDT)
From: Rahul Navale <rahulnavale04@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dev@folker-schwesinger.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	michal.simek@amd.com,
	suraj.gupta2@amd.com,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	tomi.valkeinen@ideasonboard.com,
	rahulnavale04@gmail.com,
	marex@nabladev.com,
	marex@denx.de
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Wed, 25 Mar 2026 19:52:59 +0530
Message-ID: <20260325142300.3680-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,folker-schwesinger.de,lists.infradead.org,vger.kernel.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9651-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ifm.com:email]
X-Rspamd-Queue-Id: D6941326CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rahul Navale <rahul.navale@ifm.com>

@Xilinx/AMD maintainers:

Quick status: the ASoC playback regression is still present.
when 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
is present. Reverting 7e01511443c3 restores normal playback.

Could you please advice the next steps / preferred fix direction to address
this regression upstream?

Thanks,
Rahul

