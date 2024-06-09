Return-Path: <dmaengine+bounces-2329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A013B90172E
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 19:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FEE1F210B1
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26745C0B;
	Sun,  9 Jun 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dLwuaI5f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AB3F9D5;
	Sun,  9 Jun 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954216; cv=none; b=dG4k5vWgDOqh9dcOjazqjYxy3sxdkzx+mZkrvJUK9x/XkrQvI302RDuXCDd6hI7q3EEEbb/c93XlF8w//EQ5ndXRBBuTDuDXhKi11KGmUj3qob9iw29tbHqMJdauh9cmKRKNzU0QcAJp5pOWlZD6x9L4DLVtkv/JMovN2pKPzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954216; c=relaxed/simple;
	bh=llF1AjA/gsCDY75iznxwt2VFqcsziWrqKHY7FoDX5kA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Y1NhwkfOCXGY5apNV5BnxO3kTxaPuf6d6v4jLjHF9bmqWc5W58Hvutpd1mkYvPFYwSWdpdkLiojv+zsncwQNBkT29lnWnsmkiIpID1g0rRosay/BJF9hOp/yxm8IJtUxVBNYNO2U4ZvQBVAJ9iXpAjrad0XLsST8xgXpasxl5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dLwuaI5f; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717954206; x=1718559006; i=markus.elfring@web.de;
	bh=llF1AjA/gsCDY75iznxwt2VFqcsziWrqKHY7FoDX5kA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dLwuaI5fcUOgsO4yfIWrti1MaQIc9Xyci7umYciwDCgReKeDcYvRUrcHhrnJiVQ3
	 cfaTah+XSu7YZ7G/szB62BNJnRUOatgKG/6eTYetq58XIQbrRa99auIXg3ooC5Utp
	 QYBRQb0vm9aGlfDKo20wmDxz3t3eftu7Jd51Ex3fr3GpcHeacUWDwH6bDM9lIH2OU
	 ojIdekW25P6MZsTSzbD/8Vx9ciFiRu/fE9fh8yDQ80D6eyJ37WaBYGEFdUQoxKwg6
	 ctkMOB+SoHzFgK+/8DskIG9yJuhyeqsoSjwL1BVOtdWiKU1XSPqYl2ztHAvH1zG2X
	 b1snptsE14PDk/0nDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXVZ-1s7nf43flr-002tlJ; Sun, 09
 Jun 2024 19:30:05 +0200
Message-ID: <6647d607-1424-4366-865c-069a166c61f1@web.de>
Date: Sun, 9 Jun 2024 19:30:04 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
 dmaengine@vger.kernel.org, Stefan Roese <sr@denx.de>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eric Schwarz <eas@sw-optimization.com>
References: <20240608213216.25087-3-olivierdautricourt@gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: altera-msgdma: properly free descriptor
 in msgdma_free_descriptor
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240608213216.25087-3-olivierdautricourt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxygmDObboIClb8Fc5AO4FRRwqSmTxCZMT1zAAm+60fT7uauP1e
 vI5+lPS9jWANxmmBIwR7EGr39oMvTD3xysLKIFzCFYm43c+d+xlQsrQEgJdHx7wwIqN+z3n
 XlRCY9k1WbA11+gjy30mj3fOH6ZqR696lHZIUT5OGrcFk/YTP6dtyOXsALhwcQnZrwwfyj9
 Kaf/4fggkN4QvrKJmwO4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cG3yEmUCP3Y=;wVFF4GkG3bwMumMDnndnSRj+XkK
 cqZbrqQNut03k49AU7qUo8zbcfuGBhQfEYGr/LpyDWAujmw7M3gae5YslMYgb/N/QRLLkEYlD
 hxZrvRIy18mWP9vm0POQYKJvVFgqcuHiykPwN5yEAHWO714U8Ka0pZY0a3kJVa05AtUuTW6XW
 00kfr7Ay4284/mMc6/gmT1iDBlOPuW2wRgR77tVO1K/ToxD2RlBjUddDouIC4vIGtguReBV/Y
 /dcWJpPmB57Ye3+fsj+9UCzjQoHep0MxYLyTedAmYwqNNi5E03tnCEF6fmDE8+3TrlRO5nED9
 STt0sWQwFV3j11Hzgs3RypRA9rzvWs9OIRPUtcmj/h5XEsL08WYs2OOsHbcyQdbSSoDVN6AhL
 X7VP0+49z/wna9iHOCSPkQJLZnfnlSaMpleBCmryC6ghWgQ7LCSCdeWrByvfcr4ffi+OFE+yu
 L144EHcMIhXHpas9/iFDVJEKIeJlKtm3ub9Md8uF1g1T7w7kjF2dWlYvKpPS/VKWZ0Ly76bsg
 Y+F7YtILBYf412N5k7F7BI8tkZlSMRiTQYoapy1kPe96TXKOssQLyAjTCc2Y+kmmuTX5AT/LW
 zQ3v1LOZglxFJjGGfsh2mMfNsTD/p75BI//F15hWmEBmOBIbsnBLkvrQBGBTZAfOUytSck7yv
 2gxhSWPRkEeLOIFeg0BH45HqjogDu6iA1uouiwOwh1V88LAempaRrRQQZMu5dEx5B+61i7Zop
 KDo3tL+eXBrJl29F561LTVPZQhd5+xm5HGRbZ07Ilk/DakOtQ7FOTJbmTQcAucw06FMP2k7ol
 PTB0XCSUf7Xba4L03l6N4h11Z2C+jf6LZdc/MeoTGw26c=

> Remove list_del call in msgdma_chan_desc_cleanup, this should be the rol=
e
> of msgdma_free_descriptor. In consequence replace list_add_tail with
> list_move_tail in msgdma_free_descriptor.
=E2=80=A6

Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

