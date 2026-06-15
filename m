Return-Path: <dmaengine+bounces-11539-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkJfEjYeMGoMOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11539-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:45:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27D687D79
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:45:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=OtuISnsC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11539-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11539-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A848C3062766
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0540BCA5;
	Mon, 15 Jun 2026 15:41:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3D409E0F;
	Mon, 15 Jun 2026 15:41:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538106; cv=fail; b=tSq0x+zo+XH8YUWbDrMFopmu9oE092EbOamDmIACAl/HFhGm47jPIPVSucF9fYefrPRkPP511KMnKiOGj9TPnaqzZMSZqafHoWr1QtC0ELVjxbM9h/pBwHR1ugzLAxaQrV4TjsxBCfCPrQGoW6SqbdX6+V9ucuHfAFkmHtiyJQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538106; c=relaxed/simple;
	bh=wOAl+9HNfQg6hdKdLcmfU5uA62C8fcm0aSyeL3c7N6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLrHoFkuuv7n1h3KGeFg3pp2LrF1wOm6IcZRtFkXuqmna0g6DQ95Dvc0b3OJNlo6KmP7dAmNLAoaWyoLS2ohNOKU9iQDSbDnXhkV47Ek0FqXiwJ3ewrtJBeCaXi5GWg4ELLPIpHcCks8pgJ2ZwuXu62AiY6eDI80WQVoCgeIq9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OtuISnsC; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBCSAQcEEBgmpf5xbvCadc2EIUPmxVtMbjR5kOzTLvJRVlRu4VZWFFg7+pixHfkJrldsu857BLiHFC80+IOOqV4/hJ/vX8f+1cOphDd056Pe13ExmxGs/KESkkXELIEIwKtx0p52KVwlPhmVrvzY4SVt7SlQ9j4h1QuwlwogmU91J01eS3ftbyvCyoGPxhqG/Ommm2FgAuDxDQoorHmw+R8/ULH44cGPOsyWb5X+uB47qCzO7AIvpe/orkOa1SoAltRrGa75KbQsoiczB+uKyJnt6DnhjxdQUIQNvtKyleWUu3Kuh/Dl8xVFmE1BRUAaoAkEqSTocBc3V/qHaOdYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJvo2xtvJ7JCNBOCAzrlCTzbBA3MxkeYzogCrPaIiE8=;
 b=SwpUJW6yChaMnRV/2uK9tRvUpof7pvSb9dnwxE8ppeqOhmaQzsqSweihreuxxBreR4EJi2DU1G9JxGdWGbOE/iwPg2+GLzmA9AxFeccnJg77B4P+eZpJb3PKI4cul36/K+1l8kt8NFEa5ggDr9DnMupQZ8aWLmk5W1WThbHQhRk7cbAldxohR/IkjOKt95R0pl5SFaIuhnmDNOY95HS0IHl3inblT0IQ9v85NVl2Up6G96ZLqlicJTVNaaajm3sfUToCfFEdYHyc0GT9lB1StMVvgEUUxvb5unDGdImXoQZRVUYQN+D35IhAHtOD7oM66pvvjQDY5HqksRKPsmNVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJvo2xtvJ7JCNBOCAzrlCTzbBA3MxkeYzogCrPaIiE8=;
 b=OtuISnsCH5D1/4FfujbSW6STRc4QxM0/5fkr5WCix3OX9zOQJaOAFCjrrNlSd4LoXWMl7VZx/eDeHi43TrqQ3XMfL4N0kt6MrjLPst9H2DRqZou4lb0C0+m7nq9UdL+WCObB0QnBP09zqw8KJBG+nZuWXwFzCHHefuoRwTuatc4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] dmaengine: dw-edma: Add trace support
Date: Tue, 16 Jun 2026 00:41:11 +0900
Message-ID: <20260615154111.2174161-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: beafae98-e212-4470-0e9c-08decaf49472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DKKLk6InQgwUvKNzvc2sIsF6yfwTAzXIRtQFsj/+cz6D3fAGQVJlTjUiImE/Z1iyVjH7MBPXHPhoIOkdZzwV4c58d+oLxhLeybKY0Xy7Sa+LEodkerZUkg6u15FPMHpdag0VDiWn1KYCqOo55VWQDaXu5EpYgGfsv0SUZuUdYJUNktFeGbDzXHzKtfh9yquyCwz5lIfisicnPZP9vDkhKFv6O+Z02p4HygZLqdrkWQ6cPN0WBC+oWTTUtRRm+KQMM/9snOGb+y97267kOq93c8ni55sHbQd0J/IhT69U4laPMRvgp2S15vICEtbCEnvUEj8F1kXpdtf7u/HmT+26Bv4Ppx8CoTYMxs5OytIi1TYuFXAc69+wHgDOcHaXxYyLtNq5z43zeaA0HEUjFnDymb/yrvAceIjefCKur0MDSZBKpwNT3ftSor/IsGFe7phHV9LbhP9rCUPkGCnSzdkhN4spMmZcv+CnQJ9Zfa2skD9ijDxxsHWMbAWSXlCLKxf9jA1XOPLaMLjETbzII7gtXry25zfANAK9GkaSgBUaWo/mh1weIQ3v6rAy3qyCcbDuxTCnyhf5IJ6gAStmHuWjj5kgSqq/U1SdCFWO+qItdjsI/+hsHmceuCTkgDLPCuJnuABgIa7Hrle1eXq9vk5m/ovn1JgD4t0oYKjtBD0HTZ3sz5tXMOyvqKNO7FkE26j+iphwoyRtitN2oX/jKkbiJ+90slOLcg7gDavju8rVixE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ktbRZm+MOp2B0BUkcTu8MntARPKVl1j2bt53Ku6ho6s5DpyRHTQw0v+MSxK?=
 =?us-ascii?Q?Y0xamHFjMeVOmFOCyP0ou1p6lhGzDrw58ZN1JH5vifpj7++yUtIoDBk9LYSk?=
 =?us-ascii?Q?U2433zBFGXghCp3j9BpNehBflAJm3st26oxl5Fgy/nI1Yw/TQm8DqSOirAdh?=
 =?us-ascii?Q?5A9T70qzvSMAkKMPjq2vVjACGEy/bAnznRj+lTokrX41cEodSiTkyiL/C2UU?=
 =?us-ascii?Q?QDawS6MgfmjxBm1BKfJBqv1W+dmIneJT1+3ThXsnp8ZPqOB4eNvc/cZ8h5Qb?=
 =?us-ascii?Q?uL6cLKSpxGcBKcyQ1ZREmSN4joyD8llAzDnmL0a/jAuu1zpqYCuCsfmSFqHR?=
 =?us-ascii?Q?EMnBQ0al4oUt3L0joW3ujO1YZOkCztZZH69jnptkwbMMNdl+NDDMb+8eUo9S?=
 =?us-ascii?Q?gfkSmo0+2DSHQBB/rCRsh65coaXZhVbtSMjEcKLQuBzKGjRyPzrRKXXl0nlQ?=
 =?us-ascii?Q?N8Z4q6IjlY3N4ENdgLjhIooecghGLQgEhHYrERXI9Gn/04q/VmiQFqR7OOJt?=
 =?us-ascii?Q?/OHbpOToncO3eb8qeZgAWBSgsQIQ0cRqMxtFN4uIkaQ9YcexeXsSlSfDpZzh?=
 =?us-ascii?Q?vI+TfSv/ttazy8KimmqbAICRGVYmXY5X339l78EkdqhNMmuq4s6NQxpEQl13?=
 =?us-ascii?Q?Kd2RRaACv8+OAZqwOuv4ktPDnyNXgxXHgwemk+olLd26o/2LYllvcBY7BmNp?=
 =?us-ascii?Q?0yKt0aFl+0Yz/or4BIuaeHBN4OG3D1EAG9gDBZBzataQvu4/IBRgldXVcU2u?=
 =?us-ascii?Q?YvUKG+qmfUhB+yo6XEZKjmwy0Oxhwk0PCo3MMi6fUcZ3J+npDUzkZ/TNeSp7?=
 =?us-ascii?Q?46Ap4nFUTbofDcHbCddvTj9AJtwHPp0jA2WTbv9b3wq4bMT4Q0+e5DnbA/BF?=
 =?us-ascii?Q?Xzyw5ytica3UYxpxWuRGqeNkqYq5Ii8hg3piQ5Pmx3QzJSvd61go41XOD0Uz?=
 =?us-ascii?Q?sZkI1J9K07VHm1wMA3odXoE9PQ1iEiM1q6o0ZB3v9zH4FH6aT2BiU3xINciO?=
 =?us-ascii?Q?4MrYYuEjnve267/dOJLh/cqf/9m42HMrlnYC5bK4qdgWihX0iSOWeKz+cheo?=
 =?us-ascii?Q?wG7g34YqbDIMonVhDdMqPwodnxfu2z+IcpY+mzH8vrgMjoDGPdpfeoY+Ud5p?=
 =?us-ascii?Q?eJKBircoeDWBY4ZfqaVcow2fy6cbbKPPl9nVsD+rvogq/5V1uWkmRG+mYmHp?=
 =?us-ascii?Q?NYW+uujWYIAiYZu7RL7jvfMmGrNkWenFtOv6a6m1XvRO6d53AD85DHBDAJpe?=
 =?us-ascii?Q?E+JPQEIf5K2coYBmsq0+GPe4/odo9/c84BX69XeM0B6SDl+OHW74enb906WT?=
 =?us-ascii?Q?vUDJsUv7fXyAofgu9S48DW6K2GccCx7JlI6CD8PhvYBJkXikSzx2hTAI4gQu?=
 =?us-ascii?Q?g/1LlvA+bsN2TD4CiDUiK/MvNy/3nKLIAbzzcgvilypKajOBYlRu3VS2jPJu?=
 =?us-ascii?Q?pY1XLCagJTFgWUPi2mi8H89cbU5GOP8QqcyskrmSf9j7ZUSaGTrFAIVH5IZU?=
 =?us-ascii?Q?KPcSUByY4uNuWhL8wxxvUABLGFbaEeXm+bU8FSnSKH5KAoRXVBUhjq5/3mk2?=
 =?us-ascii?Q?VucjRTvAkeew6jve80T1+j8rSqEyRNz/1C8WZeZp0xics0N2p6DMSoExf+nS?=
 =?us-ascii?Q?1yWfl5lcAqv8jMWVnAv0opMoBvPX6U/ikFJw0D+jG9w3Ks0k8vuw01GzLyWu?=
 =?us-ascii?Q?48/d4AkzW1DxUEFt4Tdn9UTJ2RR0knm2V80AgGppQ08e0pdg7i7qH1HWlU2c?=
 =?us-ascii?Q?YMXUM6gFTwEzLHqZ3ZWfJrYk8Zq6F1ooLLBh+V08CvNo/4AZ75Rb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: beafae98-e212-4470-0e9c-08decaf49472
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:34.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa5xFaL1pFMTaBbCyPL6LxCnpFCNXpGMZzqMAwlxreo8gNKyX02L4F0l9gIe/hAiRoR86omn8uwP/Bbk8KsHFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11539-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp,nxp.com:email,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC27D687D79

From: Frank Li <Frank.Li@nxp.com>

Add tracepoints for the linked-list fill, start, interrupt, tx_status(),
and completion paths. These are useful when debugging dynamic
linked-list appends and HDMA watermark progress handling. The LL
progress trace records ll_head, ll_end, and ll_done so it shows both the
descriptor completion boundary and the hardware consumption point.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
[den: dropped needless new-lines and unused edma_terminate_all event;
 included ll_done in LL progress traces; added trace_edma_irq() in
 dw_edma_progress_interrupt; trace descriptor completion before vchan
 clears the cookie; fixed minor checkpatch.pl cosmetic issues; updated
 commit message]
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/Makefile        |   3 +
 drivers/dma/dw-edma/dw-edma-core.c  |  13 +++
 drivers/dma/dw-edma/dw-edma-core.h  |   2 +
 drivers/dma/dw-edma/dw-edma-trace.c |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h | 150 ++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 83ab58f87760..3e31e7d92f3e 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
+dw-edma-trace-$(CONFIG_TRACING)	:= dw-edma-trace.o
+CFLAGS_dw-edma-trace.o		:= -I$(src)
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
 				   dw-hdma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o	\
 				   dw-edma-v0-core.o	\
+				   ${dw-edma-trace-y} \
 				   dw-hdma-v0-core.o $(dw-edma-y)
 obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index acf6cc8147a6..ad7e2a2fd685 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -193,6 +193,12 @@ static void dw_edma_core_start(struct dw_edma_desc *desc)
 				     chan->ll_head, chan->cb,
 				     dw_edma_core_enable_ll_irq(desc, i, free));
 
+		trace_edma_fill_ll(chan, chan->ll_head,
+				   desc->vd.tx.cookie,
+				   desc->burst[i].sar,
+				   desc->burst[i].dar, desc->burst[i].sz,
+				   chan->cb);
+
 		chan->ll_head++;
 
 		if (chan->ll_head == chan->ll_max - 1) {
@@ -228,6 +234,8 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		 */
 		if (desc->start_burst == desc->nburst)
 			continue;
+
+		trace_edma_start_desc(desc);
 		dw_edma_core_start(desc);
 		ret = 1;
 	}
@@ -322,6 +330,7 @@ static void dw_edma_ll_clean_pending(struct dw_edma_chan *chan, u32 old_done)
 		/* Hardware has consumed this descriptor's LL entries. */
 		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
 		list_del(&vd->node);
+		trace_edma_complete_desc(desc);
 		vchan_cookie_complete(vd);
 		chan->ll_end = desc->ll_end;
 	}
@@ -536,6 +545,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
+	trace_edma_tx_status_info(chan, idx);
+
 	/* check again because dw_edma_ll_clean_pending() may update cookie */
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -797,6 +808,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	idx = dw_edma_core_ll_cur_idx(chan);
+	trace_edma_irq(chan, idx);
 
 	switch (chan->request) {
 	case EDMA_REQ_NONE:
@@ -852,6 +864,7 @@ static void dw_edma_progress_interrupt(struct dw_edma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	idx = dw_edma_core_ll_cur_idx(chan);
+	trace_edma_irq(chan, idx);
 	if (chan->request == EDMA_REQ_NONE && chan->status != EDMA_ST_PAUSE) {
 		dw_edma_ll_recycle_and_refill(chan, idx);
 		chan->status = dw_edma_ll_pending(chan) ?
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 1bacefb10a3b..a72469c0d262 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -143,6 +143,8 @@ struct dw_edma {
 	const struct dw_edma_core_ops	*core;
 };
 
+#include "dw-edma-trace.h"
+
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
 
 struct dw_edma_core_ops {
diff --git a/drivers/dma/dw-edma/dw-edma-trace.c b/drivers/dma/dw-edma/dw-edma-trace.c
new file mode 100644
index 000000000000..2620ad61a943
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "dw-edma-core.h"
diff --git a/drivers/dma/dw-edma/dw-edma-trace.h b/drivers/dma/dw-edma/dw-edma-trace.h
new file mode 100644
index 000000000000..a908096156d4
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dw_edma
+
+#if !defined(__LINUX_DW_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_DW_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(edma_desc_info,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc),
+	TP_STRUCT__entry(
+		__field(u32, nburst)
+		__field(u32, start_burst)
+		__field(u32, ll_end)
+		__field(u32, cookie)
+		__field(u32, id)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->nburst = desc->nburst,
+		__entry->start_burst = desc->start_burst,
+		__entry->ll_end = desc->ll_end,
+		__entry->id = desc->chan->id,
+		__entry->dir = desc->chan->dir,
+		__entry->cookie = desc->vd.tx.cookie;
+	),
+	TP_printk("chan %d%c desc %d, nburst %d, start_burst %d, ll_end %d",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->cookie,
+		__entry->nburst,
+		__entry->start_burst,
+		__entry->ll_end)
+);
+
+DEFINE_EVENT(edma_desc_info, edma_start_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+DEFINE_EVENT(edma_desc_info, edma_complete_desc,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc)
+);
+
+DECLARE_EVENT_CLASS(edma_ll_info,
+	TP_PROTO(struct dw_edma_chan *chan, int idx),
+	TP_ARGS(chan, idx),
+	TP_STRUCT__entry(
+		__field(u32, head)
+		__field(u32, end)
+		__field(u32, done)
+		__field(u32, total)
+		__field(u32, index)
+		__field(u32, completed_cookie)
+		__field(u32, cookie)
+		__field(u32, id)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->head = chan->ll_head,
+		__entry->end = chan->ll_end,
+		__entry->done = chan->ll_done,
+		__entry->total = chan->ll_max,
+		__entry->index = idx,
+		__entry->completed_cookie = chan->vc.chan.completed_cookie,
+		__entry->cookie = chan->vc.chan.cookie,
+		__entry->id = chan->id,
+		__entry->dir = chan->dir;
+	),
+	TP_printk("chan %d%c head: %d end: %d done: %d: dma cur index: %d, complete cookie: %d, cookie: %d",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->head,
+		__entry->end,
+		__entry->done,
+		__entry->index,
+		__entry->completed_cookie,
+		__entry->cookie)
+);
+
+DEFINE_EVENT(edma_ll_info, edma_tx_status_info,
+	TP_PROTO(struct dw_edma_chan *chan, int idx),
+	TP_ARGS(chan, idx)
+);
+
+DEFINE_EVENT(edma_ll_info, edma_irq,
+	TP_PROTO(struct dw_edma_chan *chan, int idx),
+	TP_ARGS(chan, idx)
+);
+
+DECLARE_EVENT_CLASS(edma_log_ll,
+	TP_PROTO(struct dw_edma_chan *chan, u32 idx, u32 cookie, u64 src,
+		 u64 dest, u32 sz, bool flag),
+	TP_ARGS(chan, idx, cookie, src, dest, sz, flag),
+	TP_STRUCT__entry(
+		__field(u32, idx)
+		__field(u64, src)
+		__field(u64, dest)
+		__field(u32, sz)
+		__field(u32, id)
+		__field(u32, cookie)
+		__field(bool, flag)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->idx = idx,
+		__entry->src = src,
+		__entry->dest = dest,
+		__entry->sz = sz,
+		__entry->id = chan->id,
+		__entry->dir = chan->dir,
+		__entry->cookie = cookie,
+		__entry->flag = flag;
+	),
+	TP_printk("chan %d%c %d [%d] %c src: %08llx dest: %08llx sz: %04x",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->cookie,
+		__entry->idx,
+		__entry->flag ? 'C' : 'c',
+		__entry->src,
+		__entry->dest,
+		__entry->sz)
+);
+
+DEFINE_EVENT(edma_log_ll, edma_fill_ll,
+	TP_PROTO(struct dw_edma_chan *chan, u32 idx, u32 cookie, u64 src,
+		 u64 dest, u32 sz, bool flag),
+	TP_ARGS(chan, idx, cookie, src, dest, sz, flag)
+);
+
+#endif
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE dw-edma-trace
+
+#include <trace/define_trace.h>
-- 
2.51.0


