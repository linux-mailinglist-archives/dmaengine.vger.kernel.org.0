Return-Path: <dmaengine+bounces-12035-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d3DzJAETS2qGLgEAu9opvQ
	(envelope-from <dmaengine+bounces-12035-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 04:29:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DED70C1E8
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 04:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=Wfw7wJ0Y;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12035-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12035-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798F430057B7
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7837D11F;
	Mon,  6 Jul 2026 02:29:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6A1A262D;
	Mon,  6 Jul 2026 02:29:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304958; cv=fail; b=gYEVQWBysAPh8p8631blBhpgTHoTCarBw+YyYfSZwmLUk217EVWVbS0glSrhVYdvpo2/N1ch70RzfzfXcX1xW8+W+agnyaRLpIGxWU3sGvsQIqbn6hWxNACESvaBZD8NdGC1P2Lhh406rw+fYZ7hIStBv4CAmMhrxMZ7hS6r9Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304958; c=relaxed/simple;
	bh=xEXoMog9vowiYOaTLJo3GCwlCHCRn6VlITMtX4avdC4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jF/tlB0MQiPmIu7SeRVqWL8oCPQPej117gNB9IGj6D33ktXLgaLsqlUF7b+s1uixaagL4yLG5avLLdwYKmbbFeTsO0AkCrjG4nb5cuDjO6GinjSBhajZnJmUgY8eZNc+ekN4MNJQCFWeIbTzgMOiFNftHJlWX3Tcm47k5QcVJ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Wfw7wJ0Y; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5I/0vPHtQlBVH+PzZURip3WIkKgDjyg2zU80ZTibPmcVHDbUuZrBC1UR+epMmobwwRrnnpJCdHb6HeVuDmL8AaGMdVl7PvhZ2Jmd5bbzVLY6u77DoHkG0xasVN7QMYOyI9S66WgTVVYfdm+VUzSqOnWsUqFbLhHRlLmfS08TxYgdXXHIaPbkNzmY3G9gnEXnZi+UjcJr4chLxb7I+ojnliILfyPyVmy4i/N5nwfoeFJodJVR7Z8JtwEZhZ4iK0JnZLSpYmW0xIypDisOkESKcQ7UWGxvoWv5HZ0Nv+exweVebxtI+kmqQYPEKp+dBpEVpz73XBquEHoq32TWoNV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AKfjS3BNRocHTeNoBB73sKtai1Xdd6kP7O1yT/Jhss=;
 b=sKKSA42K8XMIeze5rXAAKe7wmmdgsXVOiqlFSrNT6dfnNt1mJa7A/o0mi82SO0GkHj9ZyyxILxzuF80R0rHf17zQQPd/h1Yf6rVGidR7aFiWRTYyvEdf+4mxnP8jDlqO4pvi1OFwmsgXVxyaC7u3lDv8CktH3g6j1cfGDBt1kYeLilgduWhKLOeVyqrAeItcg2byl9sscZ+SadBfLFLNO5F7E4UoH3xyv7IodlnOlJK1rKrHl8hAaT2/kFvwUhm3HIAqng3JmjdyLQu0S9XipEF4LaWklEBX/38Y+7VeV60eu5V2dJhxBIprqmQ/eeg97UoQthMXIId6MdPB3SDjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AKfjS3BNRocHTeNoBB73sKtai1Xdd6kP7O1yT/Jhss=;
 b=Wfw7wJ0YUYIOgNvE7waUNtvoxPwzriH5IvCXtRyskfrQqhk2K/6KrC5YcmR9CrqL5t1f3lBrR+jZotladKZJVBuhDmiTbMK0lvS6wsUmqG1kke6XpRKKxdeBirfCK0JIz5HST82zju9dD0wJFZCjtY8bmhIYh/SYyrDoLK2sU0lHCSJ4bqQQPKlECJu3lecAoa3dyGCkUthpyEE9OVoLHuzX06O/979jSg0y3V/O3+Zw3rZEBE4ucPh3Wi/LQD0BlGHb9hiASPbB34+b/XLAAiBVpQ79TyY9xF6kX+ZD4BtlayEAZIyh+pn6CohW4SR8TOP2tIiemqPnqVovcRnlpQ==
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 MN2PR03MB5360.namprd03.prod.outlook.com (2603:10b6:208:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 02:29:13 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 02:29:13 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH v2] MAINTAINERS: replace maintainer for Altera mSGDMA driver
Date: Mon,  6 Jul 2026 10:23:11 +0800
Message-ID: <addaf51275355667045ec300fc8d725e2e273807.1782911845.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|MN2PR03MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c8b978-75f5-4cf7-6343-08dedb065e3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|55112099003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	cMJd4X6BlUsjTaURVKK01z16OGbUtAG/LQZ7YoEXBJjCD19ZRMTEU8zHzVtu0BDmh+IxxMVW+gqkZ5/V0j8zNPlqEGILbr+F/+m2mScWEMNYB05z6qL10wNuQNqkhs3Ewn3g7bOR/81OOVscoNPhWIEJWcRor2zaSNnz8lHSyxCPlh35FZPqiMxql67eh9KwE7USBmMgYsDHT6iVW4BAVnVKTp3skvycULa6p+Lu9M2ZmC9fkAmr6/7aBecIvzU873b8NVtixInADzYc6/uiic0pv8QFcowSstlwIHMnxjFPcIJfemOhXqLYnMDK8fDVpVZB6GcCVORFTdHA9nghx8hzdtIeQVatVEdvssUdItWj25Sqq0uE8Xx51ssTgQVmde9W1VC4GbgpN6jVTzpmzcFzlcZboLoKGH6A5i2j4wGNbPD/E5vmW6a3Md0ByEqQjlF8PV8mkxxwVyEkQ0Cf0hSNdN01DAV4+seH4d5bcWef5+uB1g7vTHV4spZlZxKbjLrsOLNBXgp/aHg8LuHRnMQKyplQB0m5dN2yuT1/HMJ2r/C6D6TIeIAZX/E1uAicR9dR1L9f75eSWZWFslAJ1mHocxPs+kAlLzFZtc/tYlB/Rk9hGKkWbt8eTVAOXZn3fqsBa0rBtVWbTUecLsOF8blMELw/ul9F0AqAI83aaskYR+yk09RYsj5CEldUHBfCyWkVkubxPRYwUWnTDF1tmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(55112099003)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vudeVdsmUanyZQlwMYQOaSMKv4o+hI4XFE8IO9Bd9GHg6H0HKNNgpTz5yqkZ?=
 =?us-ascii?Q?bzPyQNQ3inO+qQ9VQIAVQyVDwdvn5BVjWHLWBdxQyKwvaxIeYZ4RiG4DouHC?=
 =?us-ascii?Q?FMtVhuvqpObjhHvbzQE0+rcQLfJ7KkeBsujHwI9NE7512JyXD0dm+VF2QvDp?=
 =?us-ascii?Q?KIeMAZClyvsvF6XB5BaaXwr6rhSxAVsxB9+oTCerp3BXjUCWgoAyMtLYkdEa?=
 =?us-ascii?Q?IPwNsq2VG8zKuVx4NUwG9Kg46JzV3CyPApl9LXGTjaS+/mXep/IkQa2GSJQV?=
 =?us-ascii?Q?iaaQgnRSo169RI0C56FdgoCVuC/p0a+26GZaHRZZ8YEkMjaYCjazojowWj4k?=
 =?us-ascii?Q?5bEHRkBqsGWhgVLYGTizL9gkW0TD7/SVdZasfu2TYTOj+FWP63jDy8Mhrt9N?=
 =?us-ascii?Q?h+3gEYJ4llW2ipiYIBQFAuYg7Gy+HJH6XvAdv8EdDzq76XLbqw7e3kK+WWWC?=
 =?us-ascii?Q?LmOGnEvagF5Gf95iXugGyoMkDVam9NFkthE+ch3AQA2fLxPfUf2zu953f5dY?=
 =?us-ascii?Q?9dJlyFK7fdWkdvd7cgX1JrogIxwhjm07TzqpQr1cm7YEz3u+R+3nDOAJgLK2?=
 =?us-ascii?Q?KUFqaNHtdws6ryVHZPhclKst3BZzjMDw4H6NVPySOfLLm1MVEdQKuQEsOsu4?=
 =?us-ascii?Q?PSKbVXEGKrKhjKZSmbxGJSb5ZDkDqR/FS1f7ZsJLAXyP6mSLKVI87x8BKaHz?=
 =?us-ascii?Q?mF3Fl/F8ihQBHl1pI7Vz0zcucSmsp06zPAvdRtI3JntHNovQME58bFg7Z74/?=
 =?us-ascii?Q?ID6jlrjOCU4oJJugY/1WuLJtJiLpqwjQPpEgg23+JPBSV7RiI8LRfyXiWG5c?=
 =?us-ascii?Q?0jXxfTZYhvEAEwaAymjXu55yZBKtEy2FetC0aKzVydU90qOd7volc7wDUpS+?=
 =?us-ascii?Q?y9bGjQqEGplresBoou4OwMbO1kcfHitMJaGVzU4Ti7stRtHIqdWlkyUtM+Wb?=
 =?us-ascii?Q?2FtX+E33I9De5v4Fb0Lnj91ohYyaO44mMJMh7ORccOHOelAOAlNZhj4R0zkH?=
 =?us-ascii?Q?FBtcDzpdOabU35Mp5jH7Kr8eS1EGVSYCPqTIJxlHRO+O74cu4OEorj+CtfLo?=
 =?us-ascii?Q?M3S9ZRM3jbaQBVsFwF8u7CIvKSVwR1ZACoIjZPt5+StBM25JQlvNVpeGxmEH?=
 =?us-ascii?Q?797Bd6Pgh/PgJ4DsfZ2nek4WetraB7zVEhYWitnIxYa49YFcpxU13SEZBJ0g?=
 =?us-ascii?Q?SJPFTeL5vKQeO9uST7wWYf8e/zrP+7m4O68gB0Jb0cbpQ/upi4jivtZZbR5G?=
 =?us-ascii?Q?zkqbW0H04q/nVsYA0igo5/p4Dt/U1I6OEqyObRbADdE6QNvBb8r7svW2ilKc?=
 =?us-ascii?Q?ONv0NMn5CBr4gfWN/lBEr77vUe0YSdpnjbrjdb3+WZbeuQoMqsHfRhUJsY02?=
 =?us-ascii?Q?W58dNQAY0bEBxQ1iP9iLc3stSddvLEDwS2PbT0+7ZiE6fV4hg4mmz9KQFT5Q?=
 =?us-ascii?Q?G4w557zqu4WzQxBYpdVd8y/kSZUhDWvMg72sipcwGw7Q91R+eRfhCMOWCF7x?=
 =?us-ascii?Q?mjoI4otB5Iw1nOG04ZJT1dXRbWi0NmbWij7kWFmo/sNCPHU7KwrQrB0Cj7Zq?=
 =?us-ascii?Q?9r7EqMkh3kIxpqY0GMkV2K41TdYY5Ba0fadqFroCElmjNCt6iIebDhKyg2RY?=
 =?us-ascii?Q?KxwW/V1K3oE2NbSOQlp66C40Y9HXabhJDgik9z+y4d0HXStCgYVKu2VDUa4H?=
 =?us-ascii?Q?QfJUabec8B7gNiHTRyuWeJIlPgVMebRG0JO2FHTL04hmWiTBcCeM8H4oWCRL?=
 =?us-ascii?Q?Y8NSTRMgdBZ8EPnHgdcyKoAjpTvABbk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c8b978-75f5-4cf7-6343-08dedb065e3f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:29:13.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DepFDJIwcyZRr6bocvsS0b9MMcvxp6RdxEKJwj/RAa2h0dlHLwRkQhU3shDsL4mlouqlVknZi6QRKEk0s25wGusPckyqnektlazRAjukKVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5360
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12035-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:sr@denx.de,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:adrian.ho.yin.ng@altera.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,denx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0DED70C1E8

Olivier Dautricourt has stepped down as maintainer of the Altera
msgDMA driver as he no longer has access to the hardware. Replace him
with Adrian Ng Ho Yin as the new maintainer and update the status
from "Odd Fixes" to "Maintained".

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
Changes in v2:
- Rename subject to be more descriptive
- Add MAINTAINERS file update (was missing in v1)

 Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 2 +-
 MAINTAINERS                                            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
index 391bf5838602..bea302b89453 100644
--- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera mSGDMA IP core
 
 maintainers:
-  - Olivier Dautricourt <olivierdautricourt@gmail.com>
+  - Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
 
 description: |
   Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..4d294df29a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -952,10 +952,10 @@ S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA MSGDMA IP CORE DRIVER
-M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
+M:	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
 R:	Stefan Roese <sr@denx.de>
 L:	dmaengine@vger.kernel.org
-S:	Odd Fixes
+S:	Maintained
 F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
 F:	drivers/dma/altera-msgdma.c
 
-- 
2.49.GIT


