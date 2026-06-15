Return-Path: <dmaengine+bounces-11537-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z2LWBxQfMGrGOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11537-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:49:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C0687E20
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:49:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=bBtJ2o4k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11537-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11537-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53EE6308E955
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBEB40B382;
	Mon, 15 Jun 2026 15:41:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3D40961D;
	Mon, 15 Jun 2026 15:41:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538104; cv=fail; b=oZISYO0uOJ2as3oYfw15CzSJY4zcO8VFs5drMd3Eo7OU68psiJ6LMeZTwt/wHPBVBUVwPdv/WXMcCfw0zNI+sYJI4FCiKBI3Sf8uh9hAQfoWp9BSWl5g0L++kQibnXgdPIUbpWP1xs9YTlj05nho2aEXw4ejnezdousMbpTToBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538104; c=relaxed/simple;
	bh=TWwHSNuv5lDWdC+o0laYpL5xB/ztkb80XkTgUd5Dumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrPRnz8sXvBY8PAGC9Jd2IrfRsC0xXlBL5IDEEMJMvVTRo9VS8rdqptGOsf9A+SuETl4jfrKfobrAVC9JVLCp8En3uNp6UeOXNbsO71TrrinjRFIxRjg/DzIioexEGK3cK11wSvVyaVYzi6B7guIQ3gMVvykGK13zxtxXNHzolM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bBtJ2o4k; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isyrl6GpscLXKu+b0vv4FdB89LD085NjX+Tw4p/tW1fXPPtb2HHk7+6R4rM5Tk1j3K+/YPT3zQrm0mnDydgwbxy5RrWNNSbpevYHPvrv43dCAiIk3mnGcUad+M/DMqOzI1UQ52LjLpZL22mKmhDwcT/HfD8sdsG+oPjtIF6U5ESCQH4pRp4P3/xf4i4XfWYbtDbV0Em0N7XqR5w3mUJa21pjPdsDFBAEqmvkeenlGdDo/VFrMfeEOcNid+dLdSG/YHYCrldPW+x0D4VZvcmSqaPsFbE/OpqJPHRSvsrv0FVv2GVEZcjDjIVOq6nj1h3o/hg0SYPfFWbsFhpzxEyAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkLkXMm9S9uJgPmeF/cafHanDSJrri19crEyxEGoo6s=;
 b=zLlS7x6mxtcgC6XjU6djlQiR5fggq8Z5m/MeWvrzCq/Dj6EbJCpcigLOUHnRQKdmxR/GtF0wQgn5uW7yHXJEC9r8jL+GuudekTkzXdIRxv8CmIWt69Vv2Hc2T6t6G3QEExSDD/okbVITniNbeevJQJoKQcxEPmk0L132x5w1GOvi4cqQzs1d9kLREWa/DOepdTkdXsAq/hzcC4WcssAICBteULphHqKq+PQ/p2VCjGq6C5AaALjzFFC/x+SCEoRDuNjutPZ+8/wUtRw5OSMq6w1wbzML7eDWpGBzcCxxgxMooiCbdaAA+JeNLDixeWiylbQrCQNfRHKDFZoeiWh9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkLkXMm9S9uJgPmeF/cafHanDSJrri19crEyxEGoo6s=;
 b=bBtJ2o4kZuOvPYzLLdZT7Lyw27c5HEgazMhCMflHzM2cuowBDBjl7QNGOfffUhbR4idWaIBUWEjz516ivepfhw7XPtwrjEBLZfBRD7+08ScubUYmTRCapG4YFLKPtNoVWVzqScHZG4DppjKe9fH5Fd75kcJBlcBVRdUb3NA5xXQ=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:33 +0000
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
Subject: [PATCH 15/17] dmaengine: dw-edma: Dynamically append requests while running
Date: Tue, 16 Jun 2026 00:41:09 +0900
Message-ID: <20260615154111.2174161-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f32fc9-ac38-423d-7ef5-08decaf49393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	L+KZ15dDrCLHIOYnjNsqznDookekxWeFHiMPI9+E4k0Y4coF7dOFhHge09AQkRS7HFyPH5/+1yHygyJp9KLS3YPeTRWTpbuwIxIzlsviBfMS5kg0poQQGlwDTRxd9oHRvVoHX2asAFHQ6ywnRpAahec8diXakknxK7dlfkNZISrJ8sTzALH9ZjVzBUyvKn11YG54cPSWC9VNvKSsDEPGtaWbKAPeWQnjK+RmnG1YK3zNVXL8x1nHYCxSEAvLMGKYWBfwidGLoJKR2oTcdqump96G3+zOT/EtDzrP9gWW9NfIg6R41Pw5NVHgllrYhb5MzvuphGoAC+j8bKWeKs2HpCBVkmeb+g5K/mZnLL06b9qfKVLcqyNY/NPV3cQxOJkm2GRYfKfahrIrDlsX1ko7MugOGTdOTGA0N4lH6No/ynFx/WJsdFrFtfUIgQ9us0e5zFe04+AILorZjqxxAikch5ystpAe9cbSamieGBmusm3oMp9NweFL0XMPQCYLCblsJ0li98GrIoEpr0k8NhLUl5JCTKK6GMxOJq8IlserSR7Qb0e6LPgK3Y8UmvTfdIhQTuJ+8p7S2sqgSLpo5M/YuPLy1420XwOwcxIePMD6N05kVLCyQNl+Skr2jkKUZNg9q5s1ZmH2lbLR1E7As7k0PzsHTfDKtDoYwjpIBbUpHsxaozJnBSCi7/p9VzzfVuva
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5E+aYYlYhsXGEyhQ8uFq3SXTBkje7LGD5rZ/eMHbv70tEYT0h6dfDxyhmbT?=
 =?us-ascii?Q?T7dhfQH67gw3qzJhg71wdF27SoefhqmJ906yUx5vKAYBunGySj8X/IfAEwOj?=
 =?us-ascii?Q?V0ahd3iAlG2sihiQhSKLW946FkWv2dj67S4q3EHaJluradfxw9M6bmhb/o8V?=
 =?us-ascii?Q?ZjWnNp0GmRutIeKzE+m2h9erPjsKS+0XgjpaMxcpLq1PYXi4YeTUidlyXEVi?=
 =?us-ascii?Q?ltpKMv08Mb0PIuda4QRZs2pM3Ey/wEm83oKRW2bg3CDP5Z0QfS4fg+ZBHtAQ?=
 =?us-ascii?Q?nABSEJFTj0gt0uuADRrBNJTZFMa8Qsvs/sLpGQx26c1CLMlYLDb8t/eLReL0?=
 =?us-ascii?Q?WQZmUqWl/oDlldXg3XUcUNXebQfmz2maOh7L5rMVTensixXgXASQpvGB1Ipn?=
 =?us-ascii?Q?J76/N3ZgfCqdMZmj6ObSzUy4V7vLLa+OVOpJ29Ic7/m1nlvEQzucew9ZtiVV?=
 =?us-ascii?Q?x+Xmm5jrBYfr5Cz0VuF75sFJ07Qx/3r9k9Z1q8Z2AD6LSC9zFzRd+51IBtzp?=
 =?us-ascii?Q?Bair7unVdt+G6KCOuUGI4gdanxdioWKO8PswrFU7vrTaa9lmZjwjQFFj+TBf?=
 =?us-ascii?Q?wAXZojTOm5eEujCTjD8cg6CRMJHVvd965d89QAPidh0qd1UQCTShbmJOV4DW?=
 =?us-ascii?Q?12jHX2Kk+tEvRo1A8o9Bk/Owry/TRGVAKcgtI54rfs5vplBUoq7jXqydvCnR?=
 =?us-ascii?Q?BRJmscmQld0LRQoVkVsqA/TPWNQ29UGscj5gMBpGqS8sZ0GcNqHBZlqwQlOJ?=
 =?us-ascii?Q?5VRLkH84UvIcsGODL/iZXfFHNp86NrTgebfWNY0lkzns91TdhHzvpz5hpdH6?=
 =?us-ascii?Q?zc3hUq0hmYumQDod5VLKsFO6+5myv9jtaxq7m4sj3sC31ktKG2ZvF92AYwUY?=
 =?us-ascii?Q?X9Kfs4yDAdwfZ4x3JaISAYGtxvSlCwEuo1m3KE1UABxh9erFAenV+DUwJ8k4?=
 =?us-ascii?Q?wIAOOdqa8xlFkjOMwyeiRUBzBl3uomlI6Sf02WyKr+5XFNTtAJ+KqKbs0DTP?=
 =?us-ascii?Q?GixXAvM2Epqc9RXji4r2xZ0A5mh9YpmXXxwzudqPxFM6PNNZEu/G45WUo8Ic?=
 =?us-ascii?Q?oBWbpBIAv/n1R18F4EtN7NVq2QWPMXSoz48wO6k6L78YRJdtXm2Id3GXbpZI?=
 =?us-ascii?Q?XScq0vfxs8k0qni1jo5slJT5LYQW5aprV7xJMQq+/Wle0Z+g0O7Jn6nSBwKC?=
 =?us-ascii?Q?k53THfohMBbJZF+CBGd+BtFFEKwXCSAHotqTDoBTGU9pUnLeWgwNGeYH4Ojt?=
 =?us-ascii?Q?cNEDLGdIAELSIUTw1wwuu5Q/sTOTMAT9W8YGaW7sOkolXheLQtkiuUzExJzF?=
 =?us-ascii?Q?sF3rxY9auY7Xiduvl8xuD3DzhHdZJzEOcPNJ3eraNVl6qw+Ix89lW07Nvxas?=
 =?us-ascii?Q?D64xQKQFM6HxpHCnS3nitTc3WZ00itToPViXkQZ009QWy5uRKxdaOjhHdOfC?=
 =?us-ascii?Q?g0Tz/na4UeKsCrhdtixvyppRKBoT6hpHy8l4I0iR+c/DHYmB1ogLkUE7eqRr?=
 =?us-ascii?Q?Eg9TOW8syWDqKnAVmbmgJWfOPOp1xyIW3CNL2I/DnbVZMZDCq5TG/wveICg4?=
 =?us-ascii?Q?yL4kOhJueUmgfm11wrOaW+sOCOzALQD0WbxOM176syxHtIlllh1IBIEXUKfj?=
 =?us-ascii?Q?f8vwVvb2Lv7BihWYGxn6VbiDqetD/ltzonkuVErgvlGVT3D1Bi1rVpMooFP6?=
 =?us-ascii?Q?wCqjTt2AQPecyjy3aaSniwhuC//cZehIhFSiRRfwIt7KLehnsct+WSbADAff?=
 =?us-ascii?Q?7nK4p1A/nZCugH1PlWkrdlXiUj7EZZDAdVVOSLNkFem2y789cNtq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f32fc9-ac38-423d-7ef5-08decaf49393
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:33.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y31AO2naD629A2cc47wffSSn/N34B8olGJe77iiRzHmzUeqRxHmE9s+fqvJh2SA6iFYb+wXr4hjMGT//mC2EyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11537-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B2C0687E20

From: Frank Li <Frank.Li@nxp.com>

Use the LL producer-consumer state to append issued descriptors while
the channel is still running, instead of waiting for the current work to
drain.

Walk the issued list and append entries for any descriptor that still
has unstarted bursts. A descriptor that has already been fully appended
may still be pending in hardware, so keep walking; later descriptors can
use LL entries that have already been reclaimed.

Do not use dw_edma_start_transfer() as a channel-liveness test. It only
reports whether this pass appended new LL entries. Keep the software
state tied to pending LL entries, and keep doorbell decisions separate
from that state.

Doorbell only when runnable LL work was appended or when a stopped
channel still has pending LL entries. Recheck and kick under vc.lock so
the doorbell is serialized with request/status updates and LL reset.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from Frank's original submission:
20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com
- Move LL progress cleanup, including dw_edma_ll_clean_pending(), into
  the earlier LL progress accounting patch.
- Continue past fully appended descriptors when appending later issued
  descriptors.
- Treat dw_edma_start_transfer() as "entries appended", not channel
  liveness.
- Derive BUSY/IDLE from pending LL entries.
- Tighten doorbelling in issue_pending(), resume(), and DONE handling so
  STOP/PAUSE paths are not re-kicked, and keep the kick under vc.lock.
- Keep Frank's eDMA ll_cur_idx() re-doorbell workaround for now; a later
  patch moves stopped-pending recovery into common tx_status() handling.
- Rephrase s/Need hold vc.lock/Must be called with vc.lock held./ for
  consistency.

 drivers/dma/dw-edma/dw-edma-core.c    | 121 ++++++++++++++++++++------
 drivers/dma/dw-edma/dw-edma-core.h    |   6 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  22 ++++-
 3 files changed, 121 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 4036adafedfa..477fc63e2778 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -84,6 +84,11 @@ static u32 dw_edma_core_get_ll_data_cnt(struct dw_edma_chan *chan)
 	return chan->ll_max - 1;
 }
 
+static bool dw_edma_core_has_flags(struct dw_edma_chan *chan, u32 flags)
+{
+	return chan->dw->core->flags & flags;
+}
+
 static u32 dw_edma_core_get_ll_dist(struct dw_edma_chan *chan, u32 from, u32 to)
 {
 	u32 cnt = dw_edma_core_get_ll_data_cnt(chan);
@@ -139,6 +144,31 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
 	return dw_edma_core_get_used_num(chan);
 }
 
+static bool dw_edma_ll_stopped_pending(struct dw_edma_chan *chan)
+{
+	return dw_edma_ll_pending(chan) &&
+	       dw_edma_core_ch_status(chan) == DMA_COMPLETE;
+}
+
+static bool dw_edma_ll_recoverable_pending(struct dw_edma_chan *chan)
+{
+	return chan->request == EDMA_REQ_NONE &&
+	       chan->status != EDMA_ST_PAUSE &&
+	       dw_edma_ll_stopped_pending(chan);
+}
+
+/* Must be called with vc.lock held. */
+static void
+dw_edma_core_ch_doorbell_recheck(struct dw_edma_chan *chan, bool doorbell)
+{
+	if (!doorbell && !dw_edma_ll_recoverable_pending(chan))
+		return;
+
+	/* Serialize the kick with channel state changes and LL reset. */
+	dw_edma_core_ch_doorbell(chan);
+}
+
+/* Must be called with vc.lock held. */
 static void dw_edma_core_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -173,30 +203,36 @@ static void dw_edma_core_start(struct dw_edma_desc *desc)
 
 	desc->start_burst = i;
 	desc->ll_end = chan->ll_head;
-
-	dw_edma_core_ch_doorbell(chan);
 }
 
+/* Must be called with vc.lock held. */
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	int index = dw_edma_core_ll_cur_idx(chan);
+	int ret = 0;
 
 	if (index < 0)
 		dw_edma_core_reset_ll(chan);
 
-	vd = vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
+		if (!dw_edma_core_get_free_num(chan))
+			return ret;
 
-	desc = vd2dw_edma_desc(vd);
-	if (!desc)
-		return 0;
+		desc = vd2dw_edma_desc(vd);
 
-	dw_edma_core_start(desc);
+		/*
+		 * Fully appended descriptors may still be pending. Keep walking
+		 * so later descriptors can use newly freed LL entries.
+		 */
+		if (desc->start_burst == desc->nburst)
+			continue;
+		dw_edma_core_start(desc);
+		ret = 1;
+	}
 
-	return 1;
+	return ret;
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
@@ -375,6 +411,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
+	bool doorbell = false;
 	int err = 0;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -385,8 +422,10 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 	} else if (chan->request != EDMA_REQ_NONE) {
 		err = -EPERM;
 	} else {
-		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
+		doorbell = dw_edma_ll_pending(chan);
+		chan->status = doorbell ? EDMA_ST_BUSY : EDMA_ST_IDLE;
+		dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -430,13 +469,19 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
+	bool doorbell = false;
+	bool pending;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && vchan_issue_pending(&chan->vc) &&
-	    chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
+	if (!chan->configured)
+		pending = false;
+	else
+		pending = vchan_issue_pending(&chan->vc);
+	if (pending && chan->request == EDMA_REQ_NONE &&
+	    chan->status != EDMA_ST_PAUSE) {
 		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
+		doorbell = dw_edma_start_transfer(chan);
+		dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
@@ -451,7 +496,18 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	unsigned long flags;
 	enum dma_status ret;
 	u32 residue = 0;
+	int idx;
 
+	ret = dma_cookie_status(dchan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	idx = dw_edma_core_ll_cur_idx(chan);
+	dw_edma_ll_recycle_and_refill(chan, idx);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* check again because dw_edma_ll_clean_pending() may update cookie */
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
@@ -705,9 +761,9 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
-	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
+	bool doorbell = false;
 	int idx;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -718,22 +774,23 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		dw_edma_ll_recycle(chan, idx);
 		vd = vchan_next_desc(&chan->vc);
 		if (vd) {
-			desc = vd2dw_edma_desc(vd);
-			if (desc->start_burst >= desc->nburst) {
-				dw_hdma_set_callback_result(vd,
-							    DMA_TRANS_NOERROR);
-				list_del(&vd->node);
-				vchan_cookie_complete(vd);
-				chan->ll_end = desc->ll_end;
-			}
-
-			/* Continue transferring if there are remaining chunks or issued requests.
+			/*
+			 * dw_edma_start_transfer() reports whether new entries
+			 * were appended. Channel liveness follows the LL
+			 * producer/consumer state.
 			 */
-			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
+			if (dw_edma_core_has_flags(chan, DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL))
+				doorbell = true;
+			doorbell |= dw_edma_start_transfer(chan);
+			chan->status = dw_edma_ll_pending(chan) ?
+					EDMA_ST_BUSY : EDMA_ST_IDLE;
 		} else {
 			chan->status = dw_edma_ll_pending(chan) ?
 				       EDMA_ST_BUSY : EDMA_ST_IDLE;
 		}
+
+		if (!doorbell && dw_edma_ll_recoverable_pending(chan))
+			doorbell = true;
 		break;
 
 	case EDMA_REQ_STOP:
@@ -753,6 +810,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	default:
 		break;
 	}
+	dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
@@ -760,6 +818,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 static void dw_edma_progress_interrupt(struct dw_edma_chan *chan)
 {
 	unsigned long flags;
+	bool doorbell = false;
 	int idx;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -768,7 +827,15 @@ static void dw_edma_progress_interrupt(struct dw_edma_chan *chan)
 		dw_edma_ll_recycle_and_refill(chan, idx);
 		chan->status = dw_edma_ll_pending(chan) ?
 			       EDMA_ST_BUSY : EDMA_ST_IDLE;
+
+		/*
+		 * The channel may have stopped after the progress point was
+		 * sampled. Re-kick it if LL work remains pending.
+		 */
+		if (dw_edma_ll_recoverable_pending(chan))
+			doorbell = true;
 	}
+	dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 1252d264c1ca..27a0521c989c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -9,11 +9,15 @@
 #ifndef _DW_EDMA_CORE_H
 #define _DW_EDMA_CORE_H
 
+#include <linux/bits.h>
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
 
 #include "../virt-dma.h"
 
+/* Force a doorbell after DONE IRQ handling to recover lost starts. */
+#define DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL		BIT(0)
+
 #define EDMA_LL_SZ					24
 
 enum dw_edma_dir {
@@ -140,6 +144,8 @@ struct dw_edma {
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
 
 struct dw_edma_core_ops {
+	u32 flags;
+
 	void (*off)(struct dw_edma *dw);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 265eefbf2ead..a5ffb0e77602 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -516,7 +516,6 @@ static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 
 	dw_edma_v0_sync_ll_data(chan);
 
-	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
@@ -534,6 +533,26 @@ static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
 	if (!val)
 		return -EINVAL;
 
+	/*
+	 * Doorbell will be missed if DMA engine running, so last update
+	 * descriptor have not fetched by DMA engine, so DMA engine stop.
+	 *
+	 *	Most like issue happen at
+	 *
+	 *	  DMA Engine		|	SW
+	 *        ======================================
+	 *  1     send Read req for LL
+	 *  2					update LL
+	 *  3					doorbell
+	 *  4	  *Missed doorbell*
+	 *  5     Get old LL data
+	 *  6     DMA stop
+	 *
+	 * Workaround: Push doorbell again when found DMA stop.
+	 */
+	if (dw_edma_v0_core_ch_status(chan) != DMA_IN_PROGRESS)
+		dw_edma_v0_core_ch_doorbell(chan);
+
 	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
 }
 
@@ -553,6 +572,7 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 }
 
 static const struct dw_edma_core_ops dw_edma_v0_core = {
+	.flags = DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL,
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
-- 
2.51.0


