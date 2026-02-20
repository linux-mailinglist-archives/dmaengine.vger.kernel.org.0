Return-Path: <dmaengine+bounces-8983-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5ZP2LwEmmGlQBwMAu9opvQ
	(envelope-from <dmaengine+bounces-8983-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 10:14:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F41660CE
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB723016CAB
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5D31AF25;
	Fri, 20 Feb 2026 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Qfw7/K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E23101C0
	for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578877; cv=none; b=ZHsw9pMv9tq5xrv3NIDcJeb1iFM3CmmHqrfKcLnYFL7Dxp/D2fA7/GOR8DXxvDRY8wJN+2g5C2JwqT8LaeNqxHEJspf5WMza/F/vmIhjXUHZBi64jSWj8Ll6TEiiJAwUJZWVecqiib6O0TNq8m9TCMCUtC7qEx+3I4haDfzrnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578877; c=relaxed/simple;
	bh=pdAAxDDaMxvpNAjV/CctTPs/H4RQbciZErv8mqLhoHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtvT3hU0s42iDxBe7agqa3K3hQ65tKbG/ehF7f6ggBy8csF/1SxP2ybuw/LOEyen9Nd9h/ggseDayPEVEpvsVtBwW8v0jurtUvKWt8KnACCm2Ann2UGL3PFdloQlpxyXlxjAGWtSoiohgW9VWpGTnX48MVWgUd52n8Rl+uvJcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9Qfw7/K; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824af5e5c81so1842335b3a.0
        for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 01:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771578876; x=1772183676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdAAxDDaMxvpNAjV/CctTPs/H4RQbciZErv8mqLhoHI=;
        b=C9Qfw7/K0YPVDm2P12lgSQKcT684+Egjc29TACXxeFAKdArIAjrbYRdEX89KsJoNAo
         KSNybph0Qq35CO8HhE5qzHf8MIZs5QNe111PyowI4u/NmlHe9l9L80SRdw5QDRiKPy03
         CKInQqskQQN6tMWIWsZv1FHIGp/9CfmXetOi6HT0CLdtV+NSO3L77UBm3y1VY8vDulVD
         nMOWAdlA6/4Wi/cdPdqNwF12ZHMzdI4UbkfeKaqXvnrWs4CV3hW3olXlHcYd7e4zEsRg
         mVoB3l1BAgnJNwEHLYPlvv1ktHJ0F1DfewKzn/Qxivfz0kftqQnEYkqkCb13Pxken9PN
         6tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771578876; x=1772183676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdAAxDDaMxvpNAjV/CctTPs/H4RQbciZErv8mqLhoHI=;
        b=UTv/envHc/4ffZ22DbkxrTeEUDbReeDUsD7QIHUjvovOkhMPTml/im2x14NUJl/BjJ
         nwHrv5o2iVhbbqnt0ZHWc+gm4iLoxznrR1Hecos1x+XyCkE1+8exYJht+odOhMe+K00E
         kVfl2EwHhd1HV6GyGkUwQ2UzrxuwlwalssV4ZCKNIZ2YyR0BiPHr+rCpZnIZO8R5Hmmf
         R3Hs2Zj0LpKD2FFZP0LElZ2ASGQDlwIHt4MQFNe2nSiwrjUidYTfC3NCrkTx1x49gzkC
         Ke51UIiJdKkXcyXlY9f5OntuUzy2Tlz4oLDbIclefiMT2w0GlY7JVe2ucxNIXCdN7Y0f
         3geQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxh/i8AxSjY4TQ2mjIbtEXRBBoUILnF952gdlM77mQu4S3KXScosGXsqRBbmw+Rj0Ls1wpL9LQPcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEf4Sa6cw4fjhLKHx5/nbT0qOVZkgO3Aua8RZgZ2VEKj4QXvJ
	/9UT3ftzzlVh9O38zgdsOvhQEi1zhPrzSFEujJLUEnUyS1gY1Mw4TdKy
X-Gm-Gg: AZuq6aLD1xhjP/jgxIdCfgSL844rrocPjp+JRhjFAu4iH04CIn/Wdu55zmlxyStPujj
	kXUzBGnoDs1CZN0JEmctxrGfLWjTej/xDpyFK+1mDLjadKbCGd1Kmxy3qLRoPJXwFfx5jMayFCf
	H5eumqaoReRSMnxza2R+NvPyIU1TBXt2xvVY78+s83djA0Z5Xid8kHg8YqQYvGn7veHi3cL8JEu
	TZ60BtxVM83ptlf+sUSrMhgSjqlTyGSWKYb4y8LzJEVKi5DYL+dMR13NFNmMbB8tr0ohL2AyaJd
	4apJvPDv7zgEZ53xRXlsicqW+vXdaQAhyEav0nb8/+5Ydg9bWM5yA9Lf7bwMjB9cx0rCzJVj8xz
	ej7rNmb2hHMHL7kYxigGLwCfrcU70hz4nURtkGKnyFoyraFgeVX1Z5fyM7uFxrdZfIjhz4s+7jB
	otqBIYkh+lHY1rD9EWgHqG6/Zmbrrn2E6NHUbI3L3GUw==
X-Received: by 2002:a05:6a00:1405:b0:81e:f623:b9fe with SMTP id d2e1a72fcca58-826d06fadd0mr1246766b3a.4.1771578875931;
        Fri, 20 Feb 2026 01:14:35 -0800 (PST)
Received: from bsp.intra.ifm ([123.252.218.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69f2asm22230802b3a.37.2026.02.20.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:14:34 -0800 (PST)
From: Rahul Navale <rahulnavale04@gmail.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	michal.simek@amd.com,
	suraj.gupta2@amd.com,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	tomi.valkeinen@ideasonboard.com,
	rahulnavale04@gmail.com
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Fri, 20 Feb 2026 14:44:09 +0530
Message-ID: <20260220091417.5865-1-rahulnavale04@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8983-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E4F41660CE
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

Hi Folker,

> Posting this as RFC because I can't verify this actually fixes the
> regression as I don't have a ZynqMP. So Rahul, could you test if this
> fixes the issue and report back?

I tested this patch on my ZynqMP platform.

Unfortunately, the issue still persists. Cyclic playback
fails after the first buffer period.

Regards,
Rahul Navale

