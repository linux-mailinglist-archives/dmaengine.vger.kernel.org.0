Return-Path: <dmaengine+bounces-10720-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LcMLNgVEGqsTQYAu9opvQ
	(envelope-from <dmaengine+bounces-10720-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:37:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26B5B0A82
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4697A3004427
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDD3655D5;
	Fri, 22 May 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRYXG2f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B971AB6F1
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439059; cv=pass; b=aoVOUj/py41I3xeHa144pwXBmSRtzP/jVBK0x7PE3CEme6spovwECaJZNIG5SneMzhpAH1tbYbVljXJIxSP+ZY/YN11pkp5AFnjtHr8QTH2MMkgGe7J8VLD6hAHWdYV2nMRUC4M03xXvNldpfGFgaN4t/iHsPO7nABB5gdlxm20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439059; c=relaxed/simple;
	bh=5nZquihbPzKQf2TTL4InKJfLQQ8/TPP//zh58s9RtqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OylWSSzj5Z5Bqpwj4HMomm+ad9ODlykOrECli7Cywx9W67zNWI08zGpujSGFvKIchHcB4s/BegaPkQzx77choUYLw9I2CtdFuoeCLr5krWIUbyltN2EKq7ODzUE/G124dPRHdEGkj9o/KY7ZLBaAODBL2+2n6E6yXmhJbdzroO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCRYXG2f; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-453903ee4adso3624708f8f.3
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 01:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779439056; cv=none;
        d=google.com; s=arc-20240605;
        b=jGNi/osBkaiQ7htwV/hbvXcZhlOhXDdfzHElQGrDMKQxgAgVGDxDA+G33ngCFipmb5
         DC2ePEQYvV3s2k3sa2EVB4cJSLaUEtFaJKL2D3l6vezy8C4rKsAV08qTIvzMeAT9b17C
         Yt08nmVG5aB2wGT+pj4hdWrqxLWZy1UWkrEASx0qKt+yA4MwaLWJ8s0sMtN8i23M6xSv
         uNYTXb1IvU9wyH7QeDc+58abDFiWwhWpx2NyDPJzL7Ra3QX4fdgKY272AIjFA2gS4O7s
         kVNwxgy5pqb1CCHAymFRShmpLG4pssljjTo14WwJKjZbkB4GhvIPeSny1y7NEit3zzQT
         b+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5nZquihbPzKQf2TTL4InKJfLQQ8/TPP//zh58s9RtqU=;
        fh=gXv4s4sQJvBle2pTc1jLdXhw1XBgG06HmH7r8PSL35U=;
        b=A2t2dXt8HLTnLmiGBID3nYtKzch+vZWYeds28p0ewB9xFOdsXrwNRLpcLj4lZXXL+3
         wNVePi/FzOoyAt33NuwOfS8Oex+BeNIFlhghv29opM6JlLVy9raQZCb606rfgathaUTt
         I+C0Z27T5CoeIE2lKdosL1tq/93IVrqtXd8pmZ9oG1q03Q4+7VKdJLqO/BrEsEF1rHrP
         btorQvZwFWwlxgQlod6yudKpXEWvj892jAbkfED04Q5uvURevfZzGA3kvavkiThDnddJ
         fdDIpm0gEzU+QN/PfFGRAm4m6eoJ/woOQdUmgtBpsHnSiyRIminxO17zLtobcMtNOvWm
         Z10w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779439056; x=1780043856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5nZquihbPzKQf2TTL4InKJfLQQ8/TPP//zh58s9RtqU=;
        b=fCRYXG2f8rUjFAlDN4Et0aelckEz0AqVX+4TokxuA5aOdyxglggKuTytLKVJnDg/GS
         zr53NSpcMzUOzoecTGNSw8+jMpoog/XrTGya4AEqQobiOsLvUqD+fZLmO3Yg6a/Krp0n
         F4Tk6f+eeTHisp2PY0gR49B8UYUdUFxwboBcPEbDRt9wz5z9fAhQbRROdZU4GLOJFQn2
         Phzs0ziXdtq5NsWRgjzuIAFBcLCM4uar2HE63sQiX9afLzGolbXsBVpb48S0sIS0z5mV
         PKD3hXN7WPLY8i+3q2dSQM3q3McFY7YIPIgOMJPKaC9qLG/chNOwaZJOQ+8vvn/09dlH
         36jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779439056; x=1780043856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nZquihbPzKQf2TTL4InKJfLQQ8/TPP//zh58s9RtqU=;
        b=qcFhoxJM1gI5igDomoZnNbOMfTJuD8N1dfMAEdbWSrPr/ayzmYvcjLx/7kPbhgsP9y
         Bgc4gcR7a5Acljrbo/SFsg9CrznQ87tEigMmFuOPl+G4k0PNbEPcjk2jLfFPxFOfMFUr
         jjCnohPXk11khI73q2deZE644hKxM0fNWdvg/aC88SvEKw+utDPpPoZCzl2MX0ndcDdy
         eID/I4xbYGne/KofMTcFKDYTpAEY4wvtuklY3w/Ku6OV//4OiKrs5lZaMSJq3y8MMV14
         6YOC7hB/bzz0qVHGZR0vJvGpNGKnpuOROWULLoK76sqRKO1bESZP8lcYPk2j29S0eqhm
         SV7A==
X-Forwarded-Encrypted: i=1; AFNElJ9L0kFIV25F271wqiElmsu7WUBp7cQ4dWmbqiby3pCcwSAmV5TWc14RuVeFiLvUOrW/GJRFNv/KXuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlTqjRIE68Gsh+H6D+iLIH/4D4bW40HEPYA5/WVAEahhQbtSR
	rVrLm5aBSlitUtiB8h9Iw4JOqbG8gNBObrDAEVvJBjVJ8dzqh4W3f+knh0AJ3KhZDsVDTFleFLY
	9J/lkgvGG5JuWgBNcuFLcROcZPwyHmuo=
X-Gm-Gg: Acq92OEM/mIMtavmWQ0LXMC7zwc1sPt9G2gwH0rYe+TWeWTMGV4GwI3M9b44DicZa8/
	7wkiJKgTG3DT52H/6lAgkBksbEveHMnDg8LAUxDGpGIUX70PDXExXn+EoCmpzIXPKUbmOfzeVha
	4IifpSKtp8XX83pmCQQ3uc4jyNnii7I77l5s0KBlnK3vMN3nMCiBYbU1v0+y6soi4dG6bIIn1ru
	0E7VW2NNXdtsvNdzK6daZttT9K6aGy60XEW+DvAcMnaC83G7xRCs4Sdp9T4OY6awB2P+XGvcGek
	Fn9BX9tr09YapS2muV6OXhh3szgLwA==
X-Received: by 2002:a05:6000:298e:20b0:45e:9db6:89ab with SMTP id
 ffacd0b85a97d-45eb38b38f7mr2456719f8f.25.1779439056071; Fri, 22 May 2026
 01:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521144755.3476353-1-maoyixie.tju@gmail.com>
 <20260521144755.3476353-3-maoyixie.tju@gmail.com> <CAMuHMdUOrE0ouHo5759k8ULpFPBS=gyqd7A_k-RTnSSk+MPGvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUOrE0ouHo5759k8ULpFPBS=gyqd7A_k-RTnSSk+MPGvQ@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 22 May 2026 16:37:24 +0800
X-Gm-Features: AVHnY4IZW9UefcyONbqHFIZtE2bXlYDU3wowxWRCUtBJtijkfj1oSK5EbNUHndc
Message-ID: <CAHPEe=FT4giuwRdCTGt6YKSa8CDJTo3aFXOAzrpn5Uh4KZ5aZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: rz-dmac: fix dead empty check in rz_dmac_chan_get_residue()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10720-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BB26B5B0A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Geert,

Thanks for the pointer. I had not seen Claudiu's v5 09/17 series.
Looking at it, rz_dmac_chan_get_residue() is rewritten through
virt_dma APIs (vchan_find_desc + channel->desc) and ld_active is
removed. The fix I sent is superseded.

I will drop the rz-dmac patch from v2 of this series and send only
the mpc512x patch.

Thanks,
Maoyi

