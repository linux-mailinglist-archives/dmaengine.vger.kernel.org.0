Return-Path: <dmaengine+bounces-8471-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PNk4KaOMdGlB7AAAu9opvQ
	(envelope-from <dmaengine+bounces-8471-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 10:10:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C195B7D0BB
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 116343002B5D
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DCD27470;
	Sat, 24 Jan 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HCKC7dK7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB123EBF0D;
	Sat, 24 Jan 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769245851; cv=none; b=YwjYpjn3DUL6tWLtUqOIuwkQxfMckRT1eb7YJdgO4nHGfvQIzxRKyeStdfC8SzyJgzDiPIRZPFIHqOTh8VdcKb/J7xLXDBzrpuHNf/ZzEBIAMd2wHHWe3WZrUTb7f/DSJpYvGR0iXWPvCKdX0l3nFuy3SjBXQObEpRlDfF2Ya70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769245851; c=relaxed/simple;
	bh=rUo/DaH0DhZYlUhLN9hL39yHPtt61JozUGnQL/vU3vQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qj1oy3o1vuIbzGGoZ93ZK2fBqd3cmNzL7x3QoJiXhuUou4Quk1pv9mdSMoUsDGpKAX+5v8oJ4jybFExgy3WfntzV392KbgS8KTT6exVdMVh/I2CbCoi072qnf4zThuIwKRuLMP3Zfgipzs7nftGkkELvUUenHz2g7bZECj/5IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HCKC7dK7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769245847; x=1769850647; i=markus.elfring@web.de;
	bh=pq56HsBTo4Ws61IS8L4EKHC1gUcyMQ+7Ebiniq6hlBU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HCKC7dK7PxogQOJtS+HQY3YAb6rc+yorStdvMf6PVI57ZJowmkXucspT955zvhxx
	 io9AX7Vs0VD+DWKDmGksPJVzTOSscPiqN9n+ZCx0HNW0veJL9KhfNCCoMXtswd+Ly
	 Kj14VY4vbADMpIBw8Ou7KzogEALSq3NKGLXztQoeNeWy/zKU3RplSXpy6yoh+1jb8
	 hE93oT5Wz8QkmYm0e6ey3LY3No1IFrtuTNeUtO5PyBzG52nbuQouXlFyyvSjB8tnZ
	 L1JVCpwKZJvgbEgEcjzjTaMNO0uFgLHMEkB+yXwSOnA7g7xpfxmSQJhC+gUFqw8NX
	 Brc3rQDFL/g5sUO+dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW2D-1vMq2J3QKj-00QgZZ; Sat, 24
 Jan 2026 10:05:14 +0100
Message-ID: <40ad7d60-f3c3-459a-a8c0-5c65476c3cca@web.de>
Date: Sat, 24 Jan 2026 10:05:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Khairul Anuar Romli <karom.9560@gmail.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260124024539.21110-2-karom.9560@gmail.com>
Subject: Re: [PATCH v3 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260124024539.21110-2-karom.9560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4SOnGNZgCpRH5SY1YGtojEaB5v50C+cyMABK94c9jnKa5hLk2nB
 4L6LBxfU2mm7IWeJuHIREU7Ug2PstPi7WSuZSvqN+109zCPp83PZuK3fbFDMuZFG6u5C/ag
 rneoaIgGaiao6AqLYYCNcF5vemunUVJkkLBFefQQsuY+Dx0wx0JU9PdBT54oKXF53SZuQUz
 oXAAoj+Eg+UjxhOKLb/Qg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8rfhtf5j7mw=;rwElt33obhITzrgF+WkzT/fquOx
 hx9xbl0lvcC6jy6+y8ZrqZBXUHwd7/4kmklHdQ0m7RT3oaspl/1HQOguj2KrEJ576mcFGGAOP
 smkrMlz09qmhnHaeIC7jbgmJQ4Wal9vnSBSfbdA7uIF4gMPBgPT4oZepvDcEWjNPJj2cq9yjG
 hi+9e1rl7jKOmZuaPmcJVhIrCTjIUeoU45j+HB73T/wXyZ7AJqeX5xNu/9ybWr8UcNvnZMXHc
 ipEkO1xVUeyCcbMcC5c6ycyUe/ifzDaQu5MFVwlILPHC3mVRSi/5FHKEGvJ/D4D8wRGIQCyP6
 0hZ1tj7XlfXZq6RCKGGXLOMvTTFXC5Y9nCg1ifVrgHvIpVUCLtKgdeKRkoG9MKjLgxIwx4TGe
 fzjjAABLCjPnuokXzIDyKEmAlKXGOk27lUSyTZVNFCmnlJcpqgLila4U27O6u4STX6m6GePjm
 gvhgNlyiHbs/oXilA5PhZ5Srl3GHteSo2WIZBjs7OW2J9NQpbItI2OE0XM0cvGNJ6EWte0gO7
 FZMoVaj942tYmICv3m6wjz3wfc/MpRh3YpJ5cWJEJn9Tyj1lzf4litjeOOOf6CdO51P17xhjz
 eQWXc/De5HJfFLBRCTfFwGFVKOfMxKW/EFnZUvmIp3tnloOVIsNzyRV41VdefpbwTKkor7vUc
 TpV/GWbaZd3NNe/6MWvOlQXazJghRowPn8Gk2jODmpPsc+hC73b/AhKUjlp7VWvVonLLZ3mfM
 Xlyrfsr5P8iCCpMmYkwwQs83d3GlCycaIcuJE/Znrse03e7LiWRiKNL2lT41buvhyzfaDte6f
 M5Q4X7JQrwlQGyKUOxbN1x1lSd2wwVmi+N7m0OjWHhKy3yE/vyhB8ZZHHSeYw1uExOG18xe8y
 1zFcPBC6TaVHbs9/4aNcsKaqYt1ZLKwxGQGWYp6b/evnLPNnrUCZwUeB7DzQ+wtqvylC70JQB
 NEY1iBPxbpj0vbmS/kDMHg5Iwh63OuY9/KBx1MZlHPpxlT2//5E6Tsvz4SF07wIjmtyadLwZL
 XoTHbr+hSBxr9xcoJgM/bdhETepibm46hp9dHUZ+4J8qDPFzDo65IkfiPkAeMsaTscWSHwLDy
 nbtw8/5ppNrRUvJL0Ev05npO+RpZyvZ2pFVl2UY2JLD2SPtODqA6OtI6CtK0fw5NUSJwy7EFR
 1vFIN54Rjqy0Z7+5Pnd0EkAamVjP4G4QslLd4m5WhngJ/iURUfA+1BPV40RflU2/7toDZIstI
 8Ls7oZT6rDV+vYkUY0QVZuKkWtfeIBIWxJUUkm0mFBowANz4nGz4HEkUdOvnS/oHTRNJM12gt
 5J4EMAGSHNxr7qDvP8y9WpQbZU4RguQ9GosslKOnPXxsrB4pLz84ZIxv027cjv0BNajG/YQ/v
 6AZhuGzATzA+AkexDTIVuLLmvA4NpVJsIIToRmyIi/ifzPTTc1MRpBmf+Ii4OW+UeuqwmLGYG
 64yBQcgUFMiv6yQzVVOhruvltApItlO17J23uds+POdVmnGYNxPUWtIN34Y1n1ETMsK+lcVo2
 elLwaUhCF+Aw8mWCKNHFx+KiPBTxTU71d2klxRTvhs08/JADN1N+/XZwrwUKrQSbjz9rwOs1u
 TRxGqOBXB4D67acMVzFBL6dB6YWxntd+UvaLywrDr+GDgJR8WofOBQo1eJg+zsWhnfiOqnZot
 Aiif1FwAMh1jGccl9HDQt526D154SWk8CDwzg7o+itKZgzEzwD5BzacUtsiNW+C856lkEOqTv
 Yj2tqjko/qPfUFSjUvSGNc3HN9S+yjw/rc+u8bQ4qVpK/NvSTwb3p8IvcyyhO9A2AHLOF6zK7
 FNfnpGeHYyrKJFG0KAhF0LRjFiSDb5GvKmeddd/TlajQm5faJVxoVXhViw92Z72WiLkQ7kUOb
 Fa3bJTDQ0kqsBkh5bkuDLxbi9P9WsJGKFNGSn5i3C/J//u1mJ33arDIwJyLy+Cbhw9dPLd2+2
 0NDfTyvu9PMQ2sYOnbKuDFxvzNp1C5wt3P2ZCoPOnUYjSisSzvPNQmaa6o2CrnRu1zEe30ydT
 XUZdECp1FVewHVUHbHqCn7zKShzUKscJm5JmftoiEpPgqBu1VldRbBv0IiEGy+r5t7O4lppaR
 CPXShye1nc2Mh3R3X0sLv2ZdHOB40LmPe5y05elnkAj2xPAkz77XWcVcbQ10nWfWWnMnVY1o9
 TyVtq7PdixLwSMZDDd3L6nM/latgeIlU46VuObgqfFsPfLpZt+zUsE//KCrHW4SXt0x11upvU
 Iab0Odclnqoo83mZUFn9RDN3/zXmY87iOn/Xe4Uvkaf+zQEAGImAI2crc8mSdg6eRIk6QIVz5
 KfSDYgCZBsT+y/vnpU1NIRK6LU7qSJC+/vEurbjBg++wQrUbo2aa17QwyXHx0osvUWfilo+Y5
 1zGAGevbrbZWq/WR4HPJ6Hry+9+2LxsPERz37M3RIPLfI+WgJxX+L2aobgiFCnk6cQiaqLjiG
 L/UR066mxdPhlP2ziWIX6kkL9J+xmke12Qyt4sqpk/LqHwgUQJkw1lKRDQiDErB01Jj0V3+Dk
 r5vYqmRs8tKNm5OU+aJa26tfEqgZI/JOAMC0CeNAh4Ya6i7iAAq5GA6dR92Ywe2cABpVeyj5m
 MuEdLG8NHYJT/JEUzk30WWK02QpBTCY3f85DM743QtF6++2fdgYt2I0Iuxk4kVWJb5CHp/5Ki
 NBi4CMgBytzlIa+rHk3F8LffUrxRDEtIuCms2cp5xum2uaS7sc6ccnL3Ut0yBhpwqfqlQa/vr
 MKI86coympqs4p8o8lVZ0GoSywif7XV8VsViIX2kgMMlGS21as4Ez7S2L5J7rGGJQT2XZAdU8
 z2ZtRS0CyLBI33sXMHkYG/j75B/op+gZdXH1NbYefhenTVolNS4rMKhsvLURLYwuyCrZXN2Yn
 gtuA9WDMviUPDWlq3k5Ar1UnuUyJMJfsZutqEYor1obC98qd9HLVxE1fhxaR0QiQaXEZsFbu6
 0Qn6Pi+J5OpI54zeA3fEsEcjN5QlGIOwn6A5W4qAi9RW4F/UKEmm3U62I0FufsQO5Yhs4wnJs
 1THQdwz2IS02HmcFxvzaWlvfbhCRBiWsC8Rw/UioWzpYaLG9r3rT4voWI3UL3xPsWscYkhbwz
 ngAV9AQETfJgL2HmeJJOhR7i6IG4xQX8ORWYbwCI3dfk09A/3LIc7jAvEBNGWASu/Kvy6z/qz
 mGz7DQGom7KkdivJJ6+6ItIGIxrAgQnRrUrjEM+SRlBQnGWjTAZqQHGtLMhsVCM/53FV2DdTU
 S/WtFGtTRpwn/7tjxYHbH3v4Kq5vTv6fOjDETL10oIYtGLgMO9/wWpkbAXqBuafLhmFvmhbKk
 NdAm9ZMsJYv5+um37hCAWqV/5hWqh/oY+sCeUtc6G4Qa+2gkV8Ib+RIoj2flrp+s6IxFBNWEw
 Fhuy4Yf7y9aX7RjbajW1xs6AWVOCUfvAy5R24e2KwWdeREMbHkwPZxpWbxuQkPpDwXD70B1Cr
 pWvpYDbc491Z9DnT3CMiHDF/6st3nw1keIjWlKYkkDa4s55A51Lug3/sel2DbxZWENvPQirFf
 G08ajPkb6UsS7DlJvmENfjdLhjyoLtZ7q8KY95Wn0ww6qBfxboyuXT4UQdVcy8S5TeywzWMT3
 7rvZsAj4CBPmM9nuWFxxxHXWDp1cDuyoLMIpaI+0AcF5xx048ZFaCwlF7jAlz2JvRHcL7ut3o
 qjh0+zgRFAsruSFYH7A65y0GtnNq77iRSB4RvHdQimCg+wPEP5mJZqEBRlfNzsX2lA8B7YOLq
 3cqW6P4YJPVJO15LsDqqdfnNzt2/cA1YPtGj6I4ahhTPfp8hFfDRy/5zE85RQ3wwPgS/PPRKV
 umMI+vA6eObpyuV1w0LGdl2N/Huw+7LhTUAqo8zoCDsalfi+em4QJ3ndz6/GEE3hY1Y0lEoKz
 YRQMzyRvieVhBcjhXQ2nyqiLTZJz561MPRsrKIXZEnpkvnpTHAuFzw6J3v/6nWsHY17on4sdO
 ACMsXqKFQXsaZOxmOVfLxt4cXA8EaAM46WB1SwBUBWJ6ykLH7JzWQRbx8Lt7lkziHTkAKv+cj
 3RMTZvAahsXEiGI7WItIO92hxTEogjIeDZqv+9rzTnl4YQBJSlAjOJrsqEddiM4c6OwhxgUWY
 OHauh6AhGOPY+z2yqtitwV7KTRXFrcRKTsBl9QT+iu2TeSc/hPLpV4fS23p794+qGdICTeTTK
 1yfPuw90CZJL4Nn2028cl9ErLsUUujiLU8D5cKeEPA1PAyu2cWeyfeUoVVoblK4IaRxz199t1
 f8Z0FEcJu/QD0t8EFv5VqjzVUqUrBRP+Lncz5391mxsCh+5Vi+BZhQkSpb+9srrCceWDkDqun
 mOGp2A3V6PcuK/CTr1h+jGp8NoueonraIv45Kr7MsJD6n3Bw90RVC2z47OiG/j8PuUMtwHs9X
 hi2vC9ZQlWbFJ1R4hodRg19ImxWuwZOiLZ4lk53ppY11yRNpu5JSf+wf0AZrIt1m2OkV9DZ5S
 lb8QWiPI54g5pWEmK8fkxBWpmClIhzdNJEwY1iTZK6jXeW+4zk/2LjE0fjXxw7YRrL6GkCO6e
 Yvb3zIszp7tWoJVHdoE1slICYIcorPMC6/FSlKA+NnFFHCy7fLTxt5Qhyypmdef3rVpD47d19
 D8ozfEePMqcrAdY/W5Lg5jZnDJzFytnE8xz+JlzzyEqe9yJ7c1djInWp4TDBM5U5p5LczYPlY
 kSwS3cv13F+lPivuMXh5R6R6Knpl4KTNuMZsvc84eAJ8k2RDgy1gp2OOpv/t/eIxOe5P12vpd
 9F7rS+op1fGeWSigv1AjKdSnI+PUdGoK/30uUCBDCYzgBuP8E+PYdqDUOtygkuYLx/jmGi5no
 rszDeFmbrOvzr1jCMMFJWd10s5jUiFkIzfExgeWui6q2BCKhDufgCN/S3ocNZgC60z6Eux3Bh
 a+vLYvQK4t3wVR2Z40PmZVE9Raa2p3O7fV5McIqhL1PcuYtVLA4X1TDMFJtbKE81B7jiFMG6S
 zgU1yUste4WlPqhFiJq8n9j4vyEzyMEYlWx4uEsxtWlq1QnhwruI0ruT84AuJng+8nqOysNWq
 cVYjVoFRp9opbcccBh5nd7PmD0QhGBmL1+Ap5fXEYm/62szZshTM7BlYu9SQ5pocnxFxcyHZ+
 vyHX6o1BMblZdnPDVg+oQNay7I1NK84tR71pKD+7z8I2NliRc0YzLLVtWzxGT2ZX3vjAifG+7
 Npm++6zvpExoC06YV/lt0yln7Alag
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8471-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C195B7D0BB
X-Rspamd-Action: no action

> Check warning is throws when run scripts/checkpatch.pl --strict:
> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:345

Please improve such a change description another bit.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc6#n45

You might not need to mention all affected source code positions here.


=E2=80=A6
> ---
> Changes in v3:
> 	- Split the patch into smaller patches according type
> 	  of warning.
=E2=80=A6

* I find this hint relevant also for a better commit message.

* You do not need to repeat patch version descriptions here
  after you provided them in the cover letter already.


Regards,
Markus

