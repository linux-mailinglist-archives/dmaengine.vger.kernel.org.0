Return-Path: <dmaengine+bounces-8644-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4euSO4YJf2mqigIAu9opvQ
	(envelope-from <dmaengine+bounces-8644-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:06:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43133C52AC
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 09:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C7393008A5A
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9A3191BD;
	Sun,  1 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NCLYWJd+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928841F936;
	Sun,  1 Feb 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933187; cv=none; b=mjShAGzXb+Q00vOp13f51gkhaCNn/mA6+lsBIOve5PPWLK2YZs7Epd+AtRxegacT1shPG0SexFK/m2fw7/KwohFhZShOl225NoIe1SQjXUcfK69dY7oZ5YC9/xjXF/JYPUD4+OMp4ubEc6FapOkqmDl3li7TVwUwEEPS7xLeXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933187; c=relaxed/simple;
	bh=a86tU1/wiz2+g5JLluSuvSAIdRxYtTdX1ZprYbhlMus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmvkU/nFhUxYBH4jqh7nE88u7ovhpIHTZJ7zlT/dhkvR1wo8tCEBwGBuPwDIuWU/OSztQ419g0aKbhEAoN+N6Bvpc7WYDd0JfKwnPpmnoo0FH542SMplyJBIbhWzyJZjHPPA5bT6a/v8O4a9zfyEH6FJAMLOlMwHD4gKVEtpPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NCLYWJd+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769933170; x=1770537970; i=markus.elfring@web.de;
	bh=a86tU1/wiz2+g5JLluSuvSAIdRxYtTdX1ZprYbhlMus=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NCLYWJd++N7p6FSOfXpyut+N7fJxf6p8ChBM7cvKr5gVq6lu8Jcf8Ww7CJnq4CeW
	 kxiSjj19W/Zj82/FAeloNLZmyn1mM00nOzDiK3MZHKoYt/HOT8VuYUohZq4LejiW6
	 +crsF76jXANm4/3QvM12cB0v5zaYoInYYEhTk3wR4MzrpV9Y7BGBT6Fs+3p8bhoxM
	 uAyxyoWf3bt5GFGWcSxhHb7nu3PROarUdbm4hSII+KUEVErev9oRJ/HxNCMiYI51R
	 zy/kvpAwQ1/ICGsjdYP/yiaBsQTVz56uZut51NDXooUp5LBD47nTeoGFfmwGd3eUZ
	 yv0QfPTyIOZnXwarTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1vHmQD3ir2-00Uswc; Sun, 01
 Feb 2026 09:06:09 +0100
Message-ID: <b219b4d7-3bbc-426a-9242-ce0673ee84b5@web.de>
Date: Sun, 1 Feb 2026 09:05:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open
 parenthesis
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260126103652.5033-1-karom.9560@gmail.com>
 <20260126103652.5033-2-karom.9560@gmail.com>
 <425fd53d-9b97-4d4d-ba21-ef35d821c89b@web.de>
 <4ae74b54-971a-4e92-8155-ef3fb00ccbda@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4ae74b54-971a-4e92-8155-ef3fb00ccbda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VgSIJkv1mBKxAsOaZt0s2MBC/Tpli6OeNwaAkmRVCkxHo0izun1
 rmfiUI0RbDOBrGDaQByWQxdWHds/uvDPvGCptrl8ksinaz9PWa3Uv4H6rwreX1UlbtrQHJh
 cZjo604Dem3xZCbWcHjDWdH3ibKVW56p9Gr57CIYzxLobw9iqWtO4OYQuub8axkoyXV9W+O
 IRm5lRc/Be031gqMKSuww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGoA9I+8IMc=;83dLWL6aHo6+JlRNGcFBXiLwHKd
 nXVtJTulzHJ0qKOUPHOFpPc3wiyDQawjJIhhqxq0mwGBxNvFr3/P36dw0EUrGvG6lwiq3qPM5
 zRtolShwwniQjthIBHgRCh1IEFz+0CQrIzySCT0jaemTmUNJR2uHNvEEAhizOmiTxeI0WWWAv
 4/dCzNWBkbNsMaH6dtJMgtkM7bBb00iEZ6v5949GrGY8iALsJvfYYvMeTAKVJbY7xbDIQFoAg
 5Mqo42qLNUDe2b1vbU8pT9CWEE0aFJl4/9LZL5oM3zgBghDJulIgIp/YtDFH/TAnHrWr9FR1G
 W01um/2/IKMnVNXTGBaEtUh7m/I2wm3oJ7hwWzXO2RkyyBHT+eVhDNv93wyWlXwUlpIM2Dtmj
 ZBQ5CWlmgXE7Urlz9Arw20tWHarPNaXTJjTGnc4gi9gj185TckEnOPwUd3NZ0e1OiRuXZD0pg
 JbxdV2pBF8Y30Ni5shuNiIMRncca1OPblh0vlR9G0C5flU/qikZJpUChpQQC1f979sZJnxnQ5
 XqvKoOX6XfbDj8jPTajOOC75V5hA8IMKdeMN5UyHs2a52fBHhBstqBr0O2FjYLmK6CBY4AG/T
 9yYBpQU3s0+1bYIfXACnYL3IKNO+kGkGA3OsZv/xXkeH6vIep/S3J/+SFOifu/Brk13PRBV1j
 TNM7pSLheEX6WwT4jmFn9/GWDB4UaxHNyvtSKnqunStml4Ra7ryl+Ordq0E7zpD0Yx5yk4ixn
 vC5Wai6L350aP8UC4URVFDMa8h7KjLeKwohFKFTOED0W0MW1qvMW9waBOGaUg9koRtrjUTI9d
 qJPGjXpMlarytwFRL3yr27R9N3QPDm3sIrVYJLageVaphkVf0WZcBOfx3AEVeaCRojX6RZgtB
 jGl103iWmR5MiBhGv8rbfjIU6ZeuHxfI2RTaovfnFBuydY3XLTa2ik9g/EDg4yRmLyX7i7mT5
 TF8nSidNuTzPrjf1exWcdDmrmlQJh/E6K3ngJu8ZRcaiXXBWhUcvyFsdeIkryw+gHsEHmz3of
 x6rAUB/FD0aJX8UXElxKJZ2pKN9lEImf4aBodFRJGGU880FThGQzcLTio6Ew49NH5/JxjeBzh
 o6kgRNZvP/EHZuMKpOVuztJdJKepKbEmrTOMxaoMQU82aDo2bqVXg2gYBukW9kKltjvWsF1WN
 RzUwei2OBFjwdrHn4+pYJuwf5Liv+h8Ux+NG/Rg6QTRJ6WKSLNHZK4OxpkxBudgCCM5nAUbF0
 Qehl/2ACafxQcew2Kye1Mkx2kV9riWtplhV7Dj51zSV7tZ4qnUeMcUBKOjiJjYoPSCVrc4Qzt
 lodG03EuAOKLBou1jBvTjRmaIprvWOzwjKtVWHZiVVRs0uPjDTyUq4K1BHkWci4StfbcZEUut
 pBO1cAC/s4zrabab36y8A6TPIhSHhQGPenW9rnoHoIXX/NKH0Dxcn5ljatTjnsRAm3QRJMly2
 ShejkYxb4K2wguCjN/y/c0GOluZ3Dy2TGymL2Dh1KLt9FVhYTS2hWkRa22jJOj/CC81JGRUiu
 aJ2Vfq3L1l2MVo+ttD7FwxI3yKPXmLBAh0cX79/XU51MgwE3Jtow2fiYsea8qjFSPHjah3y7h
 o8jMTGfkxdlMqLkSS6EukGp+yX9Fq9c3gkRw2marLq0zXTn/q/ReVCiGQ0JBWtRViJox2FQXU
 m4sWJPEK7nseeyREijNJEQqf+TU4HaREbcMI58v/zQhmHkA1sRG3fdPpk+i0/og+f9vzEmaVg
 DzNvVnTmMb06p/RFoiEbRpnSDxd0obXIDR56VUhGB+sy8hTmpJ1uuo6RwPDh+ICQx/b5iKuiO
 0YX8jtgmyNPQGsyaR0zHeU5Orwr7do+KLfuPg/6ERRTEePavEfe9d6qLirsXWr/I3cvg3KpJo
 I4beQsFICAX6Hzv8FgGj14iW3qoExmsuF7tIgaHYhpP02hc6B7ikGJNv5DRVXsYx4AarPvlhY
 ercTMZ8oSgbFC7BqJZjRJW+3chbAE3A19rJamIt8YmqvbaR48uHarWgdiy8LXuQgOj83A37Ax
 WcnGx+jny2NXrcgJtFjdsDhzU+NkfwVi5pPCIwtPSWC0mfah1HkpZHmFRkpSCu3mmk0BIf64N
 RLQH/fj5soIPPaBX6d3VzEUDfhKxA0clqZhu4jAFyPe0wA5vfFd9F0LW0IVs0HVELbJuQDQw7
 l94aiMrhDLIfTM7MAcRSiuLpak/CM11g01n1Y2xuOMy+2RtyYGrrZchQvPjRUbkfIPH7D3OYA
 6q9OdLfHRJx/sFVxAtOGjI4I27QyDDJw8vuK/GdfqmTqrY3aRNvBABKykcU/fs/EHdzFHyE4N
 ezK/XzXLI5LiHT5N6iwQfqm9kBB58srCGeW+p6YqvuUrnA4F8g1q82rj7eHmWvssN0uPApZiH
 ZpRvG4TdRoh7xZajLKA/BXRbvVGrXLInJHrv2VJk4ZfpOuN+vQjVHzPA4IB/tgWrbzi/CSipv
 CAxAcJv0PMIMmG7stwDfCWWP5tvIzY4MIEi1riUAQug5bSkh+O+5+TU/MnTJqt73Wq0FBIRnv
 kzm+98/6JTm/DleWyXZ60wDxqW2pJ6ZkjfckPVfQvuaYa/7gkft6eTrB14hrTYUlZmnzq+nfA
 nz0JJjSu8//sIn5RFwOPrg2kRaQJrEa+OrbiM/PRA/Y4vLwViP8uCLTkTT8CyhjaMtx2QlyBP
 jeM0TSiAzDW8WtV5rOmao1MxkZhnouS2Xc61l1IHfpUyGgxmjjcbIu/9VZkfuBNv5QvmxreyX
 vZ2QQ5qKvuUwt11RqEA/T3MORq5ob0dRMPjIuZ6jaFLcTuZl4mRWvDDiHok9KtxOjDEXWf4yl
 49hLj8hmjGq2Nsyla5bMhaPhBH4thuCCnWWecaRcJ6QBqDctlpLRZ8z8eNkM4gygrsQfkdvs6
 P/OlNdB6wk7IgfC5P4xEe87Vi+gJpN7u772b5R6z+6JY+YTm+mmfs8TJ1vmXTdfE0bF2crTZr
 WxSQIktmIGtDS75JhD9oE3MaA7lNiKZ4bG+nNQvnyXJh0VZypV59Q194YkPDxypDIjpY33Iv/
 XWQTHyeZHsVuHizDHGkhGqgnkmpKQUKCJdjyYYiMVfn5PvcAZaXaJ7da++//ooDLKWNaz24iA
 rjCDw3pgfoBWDtI9DiCLhpkLrTrLelTqj6LTFCXzU3bHP2CfONX2xwLL44hx720ejyXpheb8u
 U6ZHialqnQfaEisJ/sug7cOxS+IBPgiNGiX+CH++y0nekXhpLoMQUmum9PDDzM5OvNqhvv3Vs
 cJhn4mJcl+7UX+j6URzEHbHHHouJ3Jc9pCUiCIvHUsF+SYLr1lGrH/KlwwBF6Vh0RZrjCYUOY
 GFeRRX6FmIwr3Ak/aqRHujlZSeJE0fGN1PxrEbIkYoQRjcoZ45jZY6M9ch77bGRaC/3A2yuiP
 qESxmaeEkGXDBN8MhIe3AtSz1vh63VFWS4AcKnTd/z7ftPgN2YlHjuynq58sE2qyilhC4B61R
 8R4+e7CXwjiPr/0Z1WeKLJRiqKpeUdWwpHcWaq0rDU/MrFjlHZ3y2pkP3alznbSoEFP1XMOLQ
 ySUYM+BufUh8wDdA2iPVqdbL/bRi8Ju3Gnv30kCs5Pd+bkLm7gh8PuZLJf1xAcwlbv5wcbnj0
 IfStBUNWdpnxMok9kTW7BL4MNNBY7Cqm9Vy+QRE9Cz21dwYeL2MXX+iFCgzRgleqbvuKkelmk
 imCYmBY88LXADrKS7ZeNbv3Q7LYhp4JY1ny5YJXgyKgzWLElQ86FsjqYK12yW4cdNNWZzyp9k
 ARobdQdGt4Z4PfbIcXZejWfNEz97Q/Wqw4xCIj66xRTAgz3S7KCoajoBHSql3TLpjrEqRcydJ
 2EOtkcwodIn6eFC+878YbK9Rl68g852LuG1LkyW4U2Ct+hYdhVPz0qn/3ovJWU8tReUKULUUv
 QuXUNOonUHmjAORK2WRs98yTuUF4DH3BbT18Fjgcjlcl7mUlZ9A8DTkN5hUvQ1lADm/QjRRvV
 7CkCHXnGVsVfujb+/Ers8OPdqyaUMOEO9euLwtj4K9x5BGj6YX7wCKTAwwW/3P8MWNpWUwHrJ
 xpqDaOvliWLOrhalsOU5hNYCOIQtEPZhW+tj4TqGP8zh8Bo8nOUlEywj9wfnsSSDX0p9yw+kN
 duYLfWBg+mN16afFRWXxnyBWU2ghj14FbGXDav49J0ac53MN0+0SrF1Ig9vFFYP6R8WbGLvSH
 /0vNK9105U/m8NJDeMjZYDeqAH4D8wgteBXGJp0C3M8c5ooT8h2FFL2Mg/cg2vd6xFU0sbGEv
 1PUpTbUlp0n56nS/cjFwQ5XiQVNW1dP9qpUxMMi854pns6XPxW5U9v4tUSaos/Fi71IObRb57
 GWlNOt8cjHaexJcrZ2lE10QaOqLBBl84CIx9vSfrNx5WM+eV6E0QAJFlU+K0YOMW1U+6cdu7H
 KAqhOPlHidDQapypRuqvnyefZEjjC4lkX3nPrlKVf28OIfR001eZ00TTaRvkoQMy7BMSegLoF
 qYo7PjBvImdvelrswWT7pgFx/+6ieevwjAaGKdOIArsDM5AHhNcRY5p6sC2kAjaPK6dZli5NY
 TNHpHgrZC3SvlV/Ho6U4TvtiIM2ovJT0sbosF/Ljhrin+DGnvKmCPhSQJ6ihn6qWvAd0WTN2h
 deGqyDsHbS12E3kNZYc9PqLOSVhuxDULFKEUicbvtpJ0hfRPd20FXwD7XuZb7riKOBjuW8HzD
 ZB5isvvDQyrjnNK3eXtBPqLxcN2LwMCzu3KM1U86U0qex7W12mbV5PZUGwv4O5kcYjgVBon4l
 oiH141prA0C6UI17x3RBKPDCwQfAD1gJJxJcqi7KjIacVcdl4God7W/i5K9/7ywl7AUiZEGr1
 aOu3rovugdDxf8X9XbcL9aCCICFO9oAzTKV24d6K1YojVebpjq4vw2Gzf+UtUVYAyOTtEo+7O
 ZmWsG3asFJx6oh8In6grNmvBHLj0D9Xy5fO0n+kWk0WJGT7H3FVpCWC+8V2OE8Wa+WPMZzFrQ
 XSkVQbOH3At/uWIOohtVu0o4feimyhm7uSGtGH5esRRbH64DMx8UGKOEk6HRSY2nl3eaZ8jpz
 4M6ruZ66ajbrus1+rW1GvgUW4IYmtrB2xeL0lSOh2Zp8urBPace6/M/OFOysJccmP/+3pqEe2
 D/nWR6sJvTpCpJV6I40UMtMWfrWVyxHGRPZDtDkibSXeOrTAwg7pGKdOLiX7hSPvt9rPwxpEK
 OWSyrHxgNamrTWAaROwO7tKD2tZx3w9A/RFuFG7+kKshr64ZSBhfhr6fGOqAjceaet0SBI+U=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8644-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,synopsys.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43133C52AC
X-Rspamd-Action: no action

>> Is there a need to reformat such details a bit more?
>>
> We are going back in the circle.

I hope not.

But we are stumbling on recurring challenges according to collateral evolution
and some communication difficulties.


> I already put the details in the form of line and code but you mentioned I shall not list all the effected line before.

It seems that you interpreted a bit of my patch review feedback
in undesirable directions.
Further contributors might become more helpful for corresponding clarifications.

Regards,
Markus

