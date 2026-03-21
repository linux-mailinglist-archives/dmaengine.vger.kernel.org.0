Return-Path: <dmaengine+bounces-9571-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKv+MwFVvmmrMwMAu9opvQ
	(envelope-from <dmaengine+bounces-9571-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 09:21:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385D52E4248
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7088302A6A6
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34D34A3A7;
	Sat, 21 Mar 2026 08:20:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023103.outbound.protection.outlook.com [52.101.127.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAA23ED6A;
	Sat, 21 Mar 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774081258; cv=fail; b=WGShNbXrHCNzhloi1e1oF/qCyir0ZXvAmqKnzDvlvuIIDLL9Di7JNPTduBon+GgeRrwbXdEWToH3u8MhXEqFjcO1gxBTkAi7moYmUvh4F9x9o5ZylxARO3p/LtjU2NrcR1rNa9tqm7uys+Y4dN2zOTP0MiKi/tep89SxW8I8aSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774081258; c=relaxed/simple;
	bh=hSU9FMwbm3Jk4ummWTCwoeehjxdqhqFkwPugdoi1R6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpUI3o/JJird+r+Hav/DXJ8l02sVDovWaCWLUuabJSArWMKrUjx9Sh6mQx/B7chJk+sSUp6BCSIkaAJxuyeX4vb1Qf2TmEwA9McX6PKJgegXPXEMs74oFNyzjD6kuhtQRfoBqmDVSlr8hARuMkq+68dgKYdC8Z+/aEnjszAGZ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+ME1Li0KoAFTdzDjg9EDhDKRrLNoubh8FBRgL4Rs3X42T/u/xod3nXgYDGpcA+dekWLG66OtkiEXAZShdTtvDg9AxcONBwXtWYYGBqSy13GjmOc5Pui4aFbOzMPFA+ekp8h+qvx2fMYh44AEX8jtQ4429c20qR6dRePs7aHedGygIwxJhqx1Cqj/aqOSWOmmazJ5y/HsDaJvVv8HZoRFzTyXaY9P/QgR/9WlDsIIlYgIkIEDIaqE8nZft8rIQy7DyVqTrhAuGuBGg35mnxddsR+NSCEIZsZiYiW+o8tzxIWCi9/uCbn4ZcYTOsUYa9AEwg3fUlxOxwyy/i8qeprZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVPHZ0qhk2hvSe4RCcrdoleb98jg/DeDk3TAOOniT7o=;
 b=BES5qeIvIYe1lnYV4T1Tn/6QHxhIcPDowkkpNxDEZxb5CC/SJNu8rVi8D77xFh3S5EPDe4mMeZGzowvCTrMI3TTCQtxiGRgA97VCJaTDuglPGyQRY+8NimfemrrE/TE7NHEFY3EwV7t3ei5yvpkN8gnJdTm2IeLJUEIzIixAS1DSeZC6QxSSD0FhsKh7Ddnxk8UGsMthrKLUK9sTMh7VMCCJlQNyiCggOyngDfH3Tq2iZVSTQ1m15M+Xk8ok/1jjg/f8pLjNVtTyHoz9MyxgSpdlQU1pt4e/si8s0vdbq+jnN/+3tdnJ77eqnlCYGXp5EuSTCFft6qAl9VBnrwoxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0079.apcprd02.prod.outlook.com (2603:1096:300:5c::19)
 by KUYPR06MB8748.apcprd06.prod.outlook.com (2603:1096:d10:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 08:20:52 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::e3) by PS2PR02CA0079.outlook.office365.com
 (2603:1096:300:5c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Sat,
 21 Mar 2026 08:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 08:20:50 +0000
Received: from [192.168.129.151] (unknown [192.168.129.151])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 07CFC40A5A01;
	Sat, 21 Mar 2026 16:20:49 +0800 (CST)
Message-ID: <1ecfa7f7-63ad-48a7-b033-b51ecee61e0b@cixtech.com>
Date: Sat, 21 Mar 2026 16:20:49 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic and
 combined IRQ topologies
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
 <20260320-vengeful-violet-cockle-382580@quoll>
 <40fc5cb7-a5f2-4b86-8dba-1b39e1ea0da4@cixtech.com>
 <21ef18ef-a6e8-41a1-8280-73ee058fdc74@kernel.org>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <21ef18ef-a6e8-41a1-8280-73ee058fdc74@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|KUYPR06MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3828906d-c524-47b5-1167-08de8722c373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	e/l9aLjihfCIqFIoh+chNazOB9bVvwg6fpi8lRLqxKJs6IuPkVDhR5Mi1/oSs8mxYzwl/TFm1D7E4TyoSMhJbHEP8feO/8Fe6W6jwfyT3CrsNQNc6sFrLLK+jqYipNlshx54fA3hC+KCw1kKlaK+G1DV4mk6FnJgDm8EZ9rwMhti4daKaRD1RdAOLn2s2YvIWHEtF2P1QYExdM60HU3LZBuJFNTHYVGY2tJy3vQ3Z/Ql8/a3S3OSWmMOneCapYN3sDqHBaagnrspnB7nW+xyoxl7P+WkAltXkFjLhO3RJPMKQ4WF+rvFX+j80BESBuWLGlcOgsD4AYZpwE4duTN0R0gAci4MK7700sRXrPX2d3K5B3D+HhoyalxgSJejDywDYcaHDMWarA+90SAdwFM6trNd16wv3U1dKKY4cNapnpOc34b6uKWeGDwVq6K9cxBQpeI2I0kpj7ITz6PqNgwmUmRgWYDYkonF8AsmV8JoXpoqJOWvJ8pxJRU9uurevWEfOKIrOb50Q+vrvAd6MOQq5n0MVtGhCjfdvAFyamLsEVq5BUAt2tApIgTRuQ8VIOtX58pDQ6aIMlGMeiyMTNbHczQzcpsbilZDBHW7jhIx8e737TbiWOuv6SV/v2mF0XXi0uT2yFWNhr0QJ/vtQa2wcSvkxXazgJ2uVrTCsrAn+uEd2Ls6XPnwnzHLdW9TMRaCMJ/60dj5o6Kx2/W4l4cHnLvfspW5m2zA/z0yBO6DtDhdYnweNOUQlSettoQkiZ6ytDQvgZbmEKzY4TI72LJNeQ==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T04CD9DVNhSBpBPyaO4QliqJWm6oITxL1f5AEuHybqO7o06qlrPnlueZVqmZoALlga28Jh7GTGxBbv0IPi5BgNOwEurQXHrjBcA5HtcyspogeUyistdOsFov0e1rYSvw+OgweNmI6OvnyveagG2ju0iBUKlvIzWmEl95kqhhjSKl8Wf/gsrNUiULHdWdtXOqYQYUE205DHwVVCyyh68wOWfvOox7QTX0oTXdcM5C+OoHLUV/PBuCf+BNDzWDsJqxYtecsfkul1oGHPgSGDfYPXpenTvWtpYRj39vQltycZiFI/cT4SgZxwOUwdGzL+XtEFPH9vwuZXUsPOnlRNtoQvOjB5/LlTEs9PA+kA/vwxUHKYDVX54nvo6M2iJ8BIFoJqX7F0MuFl/DWXFI8wO4WQDMC0bKds5j2Ox9X+OOMAVxrYvgr2P//P7K/jYW7uEv
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 08:20:50.8792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828906d-c524-47b5-1167-08de8722c373
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8748
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9571-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cixtech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 385D52E4248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 9:12 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 20/03/2026 11:28, Jun Guo wrote:
>>>> +    description: |
>>>> +      The DMA controller may be configured with separate interrupts for each channel,
>>>> +      or with a single combined interrupt for all channels, depending on the SoC integration.
>>>
>>> And more important - you must review the LLM microslop output before
>>> posting and adjust it to Linux kernel coding style. Don't send
>>> unredacted tool output.
>>>
>> Actually, this part of the description was not AI-generated. However,
>> I’d like to confirm the issue you mentioned: are you saying that this
>> description is written too verbosely?
>> Then, do you think there are still issues with the revised version?
>>     interrupts:
>>       minItems: 1
>>       maxItems: 8
>>       description:
>>         Either one interrupt per channel (8 interrupts), or one
>>         combined interrupt for all channels.
> 
> No, it is not wrapped according to Linux coding style.
> 
> Please wrap code according to the preferred limit expressed in Kernel
> coding style (checkpatch is not a coding style description, but only a
> tool).  However don't wrap blindly (see Kernel coding style).
> 
Thank you for your patience. I have clearly understood your points and 
will incorporate all of your feedback when revising the V3 version of 
the patch.

Best regards,
Jun


