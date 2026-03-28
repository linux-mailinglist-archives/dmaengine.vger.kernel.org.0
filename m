Return-Path: <dmaengine+bounces-9698-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJjyMJNDx2mSUwUAu9opvQ
	(envelope-from <dmaengine+bounces-9698-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:57:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485534D1AD
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 03:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8927B304EEBE
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6835C1BD;
	Sat, 28 Mar 2026 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izAFUHPR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81B70810
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666634; cv=none; b=HbQCcdQLptKK+mQFGmGZIwtVM3VOyBLXKxiyWdve2dssYs2wcq6kC/lAqTRXs+xEIWpAUnSvwV+R8aU8SZp+8ozyZ1mM6+j92e2sGianrelKwTC4KsPGUWvKKDo9kE9ZELJmLhyFIpJPa8Kta1fLP4ozs2bHrMd/g5jr92A1KcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666634; c=relaxed/simple;
	bh=ZKSyHxoYFuKiNzZX+JjtpSCvfxxsyN97iNBDPWYv3yQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S0I2hFj5cKFZ+gwlMM0gncLHMkicomvWdB8OAyvyHieIEdFR1K4D6L72XlfeLnc3drgS7SFBsul3n/fWI8TCq01BjdQNDeFUXtcwM+jX1dBiwdA1p17QFVVjnpEnKga/ibshl4iwg2DIdxqVFtOAF3isjxP42PGMChA9mhGEtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izAFUHPR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so26766735ad.2
        for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774666632; x=1775271432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eQYEY5T0O1M6pGhs9vK0GFOm81rzHyn+lQsiQewH+g=;
        b=izAFUHPR0QbzZGAqdhTYJEMeu3H7HSyM7qZbcXJ1Ib0faaQBSV3BvMf1jsg/Aqb5pW
         8H0qmYuTyxliYAhyTB2gOFma4LEYC8i0HoiiiHKzohjZuiZDSTBnV7S3HTxbSjzDQsuK
         /1XRsXYe6N4swDqW3geOieQNRMXzysj/WgjvLCjZmejKwh4RamXX3BG2SD+FdK10UkFN
         ifMLH+IFh4VSG/RPwRIQCP4V0X5+L/I4VozZj+P6WoJ4yAoCsjpfzcn2Np65+Fp1YAfO
         YPfv4IVZ6HiWM9VAtYBPNmQ8PLtahCY/NmhRVhuDuNkD7085yWhR3Cy6BuRFwP7iVoR+
         ehfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774666632; x=1775271432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eQYEY5T0O1M6pGhs9vK0GFOm81rzHyn+lQsiQewH+g=;
        b=SBn25ENqVSCsq7aaEx0oF+vcyGpuC7gFSk7spa07fiBfHrLcIKva4JCFRjR0WcEKxP
         83W8QM/yT2vahWL5OqF4VBSlrH1RMv7ZQGrjk5qy1YZkcgoQ6NmcVQxBMHVebkOTuRlo
         U+qOdFxnEMuAgVBF5fJx4Bu6NhvvOmjAGf19l25XidDiaryA8tsd0ZREgZrXqIM1Tv3i
         QDCDVyl4FVK78Dwjb73yDRX4BTxek0cXMCVwEBLLW/40IcNH3qStg1legS71XWt5QK2c
         YQpx62flmT+dtzNeLA6/U7rN2hTmLvEAuL9FtQMQLyiVsdXXuiv4NNgujuXuYfniDGKc
         mjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo0zzCu0Ip9obnu1kcR2KQORfV+mSTZv83wuqVPkIZKKgyA9BCUZfGU87a4XIKPamLmA2N+won5LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkADrXvCjX42bBOZlyW96WI9aC5f1NsiFtN6dSyYXAIgsy5OTT
	JegJ09OnAsk7xDD573CrAR2pwyeUKWUVGnUwZpflG3N3bRIUIHUF0mxrxIAIPQ==
X-Gm-Gg: ATEYQzx9nx+4cGh9JRNPayok70AstY85YSW7bgRA3detH9ofNEzBu2ngV25grS7oMbs
	c4VlOsrOedyrujKVItBUsQ0KsKu9dEu+hm/7MAOHAE8aeV44zvLrRNapmaGcstWF2EPlq4OjRSk
	edX3mPFFZ2nX0oabOfle4qaMwsbXdHyeAhFj/cOm1KBv0z4rps80KRqEJHWTCZ780P4ySvJFTs4
	1KJAaeBYJ02iOrkYjO0fJ3GRk1aI7v6a0t6wrQPze8miBQbtPe3ETAu+3u1EWRoAFfFpdoNKAD9
	RULi+ehYGTU/zzE78Eo+EhuAIh+XvOSs0Ius4dDcEit8iHA1FdW5ezM3qf5EsjrwsulkW2JURyz
	wWSVxg36OE5BPyt4h0ggPxgoZaa15zVz9uV94k3BjxNT64H6ADCJISr+kpem5Wqfc45HjVkF/h+
	rQlrL8Ht8ZclNZrtvzd901tPa+QOIJ0hnoF+CrewpWgfqZcxA=
X-Received: by 2002:a17:903:1a07:b0:2b0:676d:973e with SMTP id d9443c01a7336-2b0cdd0476bmr48799705ad.46.1774666632154;
        Fri, 27 Mar 2026 19:57:12 -0700 (PDT)
Received: from localhost.localdomain ([60.49.20.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb50sm7194835ad.56.2026.03.27.19.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 19:57:11 -0700 (PDT)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH 0/3] dmaengine: axi-dmac: Coding style cleanups
Date: Sat, 28 Mar 2026 10:56:54 +0800
Message-ID: <20260328025706.52722-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9698-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4485534D1AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series contains a patches that fix minor coding style issues in the
DesignWare AXI DMA Controller driver. This adjustment were detected with
the help of the analysis tool “checkpatch.pl".

These changes are purely cosmetic:
- Adjust indentation of function arguments and function calls
- Fix the line ends with "("
- Refactor NULL check using logical NOT.

Khairul Anuar Romli (3):
  dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
  dmaengine: dw-axi-dmac: fix Lines should not end with a '(' warning
  dmaengine: dw-axi-dmac: use logical NOT for NULL check on of_channels

 drivers/dma/dma-axi-dmac.c | 52 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.43.0


