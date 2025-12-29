Return-Path: <dmaengine+bounces-7956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2392CE5E21
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 04:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8EA300CB98
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0E263F54;
	Mon, 29 Dec 2025 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fAn+7vlM"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA120F079;
	Mon, 29 Dec 2025 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980157; cv=fail; b=HUDKtKBJI4onhgeVNXWYTHrW7EztDLA0xxevCEvAaDem/Ne/gsxrvVxqgDx8GCGHRjFB1hPAsltoK1PgLedZTkv8+uRpZSKzCzhVr/VcAJXfQVOerrXjcdaEz5EU+dyeWUqH9MgjrDs7i2WKWfWU6ER67EKUO6zv6pmSP6YZzoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980157; c=relaxed/simple;
	bh=O+FvS6WimF6aWrmCcHYgzhYmFcQGGixb3TMrS2gUzQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kI60jlGvFXNuDcAzboLNaNaf8pAQwGdKBEudTFg87AdzdbPt5dS90NILozptq9ks4792iVMozLxRcmebfaqYwJ4eVFuXBEBtirKtcAuhav9e64e2hvox244T3absbMM+KNXDI5tiJxF6r0YCbYOwvO8FPRxMWb89R6DpnF3kPxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fAn+7vlM; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+u+sa8ZiSnQ6uSV+iuFVIqoauMhjB62R7Xg25ipDyMg6NKZBJJ4DLrLmX0HwVqg0AS/XQxnoxr29ejpdwcPg3kzUcaYBWirtUiddz+cCv00x6TIvXqowUsepMiLMv9j4c8dRf1mfyhZOkcoN4efIHYfjDtK+y2HMIS+O/rMjeSZqPdUPJg4IFOyH/KT/leDL9l+cLGOq1WQxtEaVdUA9bXFev/BeoXYCqhZRv+gyqfFP3pinJTeWh9ZyNivqBkG2szlJMV7MMiqR4CbXE6BxjsXhTS2AtxE7JBxyu12Uzrevjo4NK9k+ijHwxRldj20w1fLiV6eBpZE6d04zhJHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUFSD6PN+oas+WLNegtZmScHipKFaNBwO30is/RQHYM=;
 b=WdED7rX5RTrqNMLjtS+g6uWOPfxjixDPokRWCp0FdEWKZkyEsIkJ6dkFVhB/DN5h7lkVNs2wpNfllUav5sQl8DklRc3fCsj340x9Hp9+SvE1cP3Ehg7zM9/pqJLC9RkMZM9m5QufgMCTiUNGoAvvxkvanZo8xYgqceBZ3VzqCELNTJDm7FpKEGyi/MPwp7mOTRcMyIOXzM4IIo5H+ZnXbuHVPX/LRH9nqMVu/nWxoMH8Top0sDJlcxYDThMtzMD7YueDM/RtaTVjFwWw6mSbsXs3NmWKJzO0vbygwwOKu9zMqJnBo/vk5eBnRWpnWxD/l09ip2kV4TyQxrR+zTOHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUFSD6PN+oas+WLNegtZmScHipKFaNBwO30is/RQHYM=;
 b=fAn+7vlMDoCqw0FFqcv4uiKnTyw9gE0jZkw5CbbMEjlG0o7zzQKQ0FMcxrc5P1PwxZMwv7rLzaHwfns5RoACAMuI4300RdIScqdT+6c6IQr9Miz4s2IPv8b9KX3t2dDKcBpZGgoNRGeiUf9uBr0oUhucT/MuKBuySMPNwh2AqGOGiIFaTlYq6aNTEjIBnhkV5wFzY0JP1UR6bk8TsSoDau2h/f9jjPMUZbydan6IK0jgB8sJ5lMCi9zZLXhr0dNYZg7/QwpdDj/lYkFKcKZjd6/xeknPuNbOCVoua8qPDmFS0opohT3jdwTHlCPi0P/+0mGj9bKcB71BAOMRQ99oSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA1PR03MB7055.namprd03.prod.outlook.com (2603:10b6:806:33b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 03:49:11 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 03:49:11 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v5 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
Date: Mon, 29 Dec 2025 11:49:01 +0800
Message-ID: <dbc775f114445c06c6e4ce424333e1f3cbb92583.1766966955.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1766966955.git.khairul.anuar.romli@altera.com>
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA1PR03MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea10f69-e45d-4875-367f-08de468d39f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWYmjDY1UzpdabvmfTp4FIaCqNynDlB4Fg8Z2tj/UjS/4NcNzEE+HHs58KMb?=
 =?us-ascii?Q?+bOKcy99ZKQ6TYQ8UG4KBEbHjoFaZmt2cB3Zq6Y5SAFTutLfaySI7KkYdINN?=
 =?us-ascii?Q?rVOtouLddTA8a71TCmR7TZGZn5WFwsWU/m69FFbxrilYizWjxH9MKmMzlUuv?=
 =?us-ascii?Q?wXhZmi8eh+n8kzj9trgQek99qJkUVXEEfI1BPj6e49WfFk49WKRv1Yse/njd?=
 =?us-ascii?Q?vU7HZftuJSaM9wPk//64xMBkTgUyH/1a5s/AqR4k43eN5A3ML63ZaEakSKfx?=
 =?us-ascii?Q?T9KMTKmCk0Pwfk80lYDHbwGkLi9CNfVqxTk2narhvCsh6RfaAUlhNHNqPS/H?=
 =?us-ascii?Q?YRWWUtqv+tC0K58x1MADN1rpb4F2lDQZ0Je63iuO8v+XV/xiFQ4BEk9wfb5j?=
 =?us-ascii?Q?GMqB5o2J230nPGxERrTua/d9Y3ZXuVMT8wEWtw1Tp7onTHeYyW1BO8co78lL?=
 =?us-ascii?Q?fKY7/rdB2M/2AdnXRHVReXJEoYg00PhLrJYPCHmOhxqS7TmVBymZQrmQr8Yz?=
 =?us-ascii?Q?+5wq9MdDeR4wJ7KfcdPPamsHkPMp4qxlBY7gCVnfYASOzI4lNkrz3PAiTXwt?=
 =?us-ascii?Q?b0hNyfTe9PbP+pvFKx96WXZEkTVj4LoNB8cJlVGh7CO2+zDba2YEccnw3nCm?=
 =?us-ascii?Q?O96Flfpxvg2Bb/0ZYLzQWqfZdvpR1kfOTAwXOPznbD7c/HW8ibV0PQ8D48xF?=
 =?us-ascii?Q?DTD3WhLPNYqPDvYgHQF23AC0uKBnDFyfdZxsOZNAZxXvS51B1x8uJa6cSD2I?=
 =?us-ascii?Q?TFe8N9BjiVHXYDftJyLgYR7lCK1e+7Ik4eoSKx2XRF3+zNVq9YPTRW8yu7Z+?=
 =?us-ascii?Q?aAzBuZySy1jvsm47+iwyGT1ZfD5kTklDsUb3x0V40TjEd7jgq3oRIoHq6j0G?=
 =?us-ascii?Q?HM+4JZfDTaFM50J2CWQF9E0q0TVfN6/vTOe7+FcxLwwZlUrzVAcEKDC+UB6x?=
 =?us-ascii?Q?nopwoR2LPSVJP9hMV3NXWIr/TGVkR3MjovqO0q1bOkjMuo1MhGKMVxgq7LT8?=
 =?us-ascii?Q?fSDQKz+v+XTgq/SX1VSSuG00n9xQx2BCYBXhuyOdU2ND1BW+uLpcgQyOPBCX?=
 =?us-ascii?Q?bNGJlxlSItsta9ksZ0Bg+iKTO8VS277SDtGqEZuuS01FVE38mJBCnNbzb+hi?=
 =?us-ascii?Q?XZxocm1bpTTUdBAdzDZoo27mcb40ZhsDusydlUIJhtbjhvR6E7fOsrj/9Jk+?=
 =?us-ascii?Q?ZcZbm60RsEzr2R1AXHLahDK4BEqfxITMaMfHbJRTCBT/PJnC7uAvJ487Uetr?=
 =?us-ascii?Q?Z/Mz8p80ncFQSGDiGw3/iE0kgwGqJ9Pwwjr7wKWJEG9hMMnF9QiP4s9CMiqh?=
 =?us-ascii?Q?W6WARXJPDHsLZGu4VKuvmi3/36d3zVnnWVTZvbehbCsSk0lU2WKKu3mg1Bs6?=
 =?us-ascii?Q?csVRU9j03xkG4qgbc87AU9eWxGMhRoW6ADgn8CDoduCOlIVOB2R7OjzMMYRJ?=
 =?us-ascii?Q?aASyuKtjtTqGllpQ82qCQ78KXxzeSi5HHZ18en5YE5kgABoIIwipV4546jmV?=
 =?us-ascii?Q?HO39sinY0JQK4os=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ho+GLzBt9dx8Pi+Sn50Ou5yn4oGEPDoZOhK7Hp8D8zrXwiFTxxvCbL3CpEeB?=
 =?us-ascii?Q?miygAIq1KKZuWMv2wCImvg39r9G0Dh3ISDLXekF8RyDVwFAyNJ201Mmg66em?=
 =?us-ascii?Q?9S9ZPc/CQBzHwW9HIy+jGR7KWQsxz9zdB0hQNOKnOyriY97bq/YE+WQQByf3?=
 =?us-ascii?Q?9YFnVJ9Vs0EMHc91/V7KbNgDGhMqdnzOHmtMPNZz6u+jW9gh/wH9gw2Ak6rV?=
 =?us-ascii?Q?YbrhDXH1TkUVAh49pOcoKHkthoMVW2zS5e1HtAChmk2rALwG+jqVxsl1mOu4?=
 =?us-ascii?Q?5ITi+QNZZy+hqGtBP3iXOpRdZvYBFO8iPz/vWzNx8ygPNtIf+2GZj9Ox01z0?=
 =?us-ascii?Q?VapTEfR6e9CeHqeoLU64HoyB7EEsuVpPZOF1wfGmN1/qKb+Il7JM5rOYlVRc?=
 =?us-ascii?Q?pfDKc6NEQ68n/tTaGkRtmVoTxnZ7sxls8XRtIaI4q53bnD3KFinX92gDjTjf?=
 =?us-ascii?Q?V9Ltfy98REwEXwR9WKKJdipgezGW71kVVfaQ56bZs4pvRvCBHwb7ONC3KY38?=
 =?us-ascii?Q?IwNUtDd9QnK9/fBzNKLNJcHH28082NeV6msWX89fjd7HkLI3kL4s+YukLaPB?=
 =?us-ascii?Q?cJj+cSE/BaBWf6W8cx1pnKDXnTeWVu6B31DSfQ+6IsPoSnv2eLCs3TdH00Kz?=
 =?us-ascii?Q?2lhdJMZDQCDuhuq1duT+BMnL50vLJuP9Mb4N3bc8t1FAAv2ITkxWQa2fHu1N?=
 =?us-ascii?Q?qQUzRNxC6gv9ZuJlyBwYBx6kcP1s4ui+oJdP93UvRmVqXZNsAF1Gp7fr3M2O?=
 =?us-ascii?Q?SmlhfVsj+8PJ8ozd2OcQPfygyldG2/mvzQj8G5dln6pMDxWSUNht2OUsTzjl?=
 =?us-ascii?Q?1frVqLfuETL3cxkznImgjrb2tIpomfKbTEvr8Wd0MPAPolX5ce64ZA1pHEe3?=
 =?us-ascii?Q?4kiZNxSDSQJYv1kRksKvarC6jv2tz0ytZTvT+qISqe35ZhG+toXq6GyF9X9F?=
 =?us-ascii?Q?eFYv26qs3VfQoapFFhwu0a+txex4Y1vgVM7tR8lZTpf/M0nRHIQj3jeufEU/?=
 =?us-ascii?Q?XUAJoWuPVtKP5BDs7xgktka0CVwrOb4IVvqAcr0nXd5Rx1jD6KwmpAdUL5Fm?=
 =?us-ascii?Q?mWDu+vRstXxes3SSNs8VcTTuKP0lcpluVDM3EktGdcAhpcjxglkJFUpl97Wp?=
 =?us-ascii?Q?FcUnSMOJPo9b7yTootg3rCpHonrJoJXpU3WjDep5VJb/OwjG/a+aM7XaJD+z?=
 =?us-ascii?Q?9DHNsetLfJUu2yMQMifYFlFadhH/v2+qBQhwFz246bmv/ZZQ8LYYcXeu5lC4?=
 =?us-ascii?Q?TVG4g2xfNcQLeK690LK1LaHmh4lVWH4RanBNmBCHghrDxO2TUJtUMfQmNxQ7?=
 =?us-ascii?Q?KVKZ3NoeIrmmlumAVrD4kbRAnTi640qJGtSPHdlV/X/2cxyS0ntUOtZnPc/s?=
 =?us-ascii?Q?bv/nhKyjoPi2TPGBbFp6L42CgoVzHMsR0O/Q4ewFcWRVn/LcSinX7WAaR4bi?=
 =?us-ascii?Q?2/iRd80Xxd8mvvESonHr7hGg35vilBxTP45xLNfGS1/5qeOhMor3dXsVZCLJ?=
 =?us-ascii?Q?SoQT7pj91vUQ8WyDimsdfOzOK0EWMHu/LJquwirDa3VxF55F8WNi+N8tnJ/J?=
 =?us-ascii?Q?EgPsSfXFCST3zfFeqtt/g3iRsxPNFl+iw6DDU7UxvvDodx2FsHBAyAKVjNNT?=
 =?us-ascii?Q?hIjdetzx+oGCBtiw92FstEauzb3pQl+CcDo6OTDIMadHJme+MOiCgODCQapA?=
 =?us-ascii?Q?PWRluR5TU77eq0fP//f+2wYpNoYnfRTfdqeNfi6yhVGiVAs9MDcv1sEgwLqw?=
 =?us-ascii?Q?NjEBSlHehHHgeuEyyG/SwmWBshFlvWY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea10f69-e45d-4875-367f-08de468d39f7
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 03:49:11.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qhn6rQbjYTQ1EDrxcWs23/YcdLo2JyixNLqiAiGpn4GobgNsJW8DetBYe3T1jSMnayNpKi8zl8pzjTSFL9lRtt36SEEGwxir4yPaFXCuk1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7055

The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
will cause address truncation and translation faults. Hence introducing
"altr,agilex5-axi-dma" to enable platform specific configuration to
configure the dma addressable bit mask.

Add a fallback capability for the compatible property to allow driver to
probe and initialize with a newly added compatible string without requiring
additional entry in the driver.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- No changes
Changes in v4:
	- remove dma-ranges as it is no longer required
Changes in v3:
	- Simple dma-ranges property with true and without description
Changes in v2:
	- Add dma-ranges
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index eb67348b4ab1..e12a48a12ea4 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -17,11 +17,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - snps,axi-dma-1.01a
-      - intel,kmb-axi-dma
-      - starfive,jh7110-axi-dma
-      - starfive,jh8100-axi-dma
+    oneOf:
+      - enum:
+          - snps,axi-dma-1.01a
+          - intel,kmb-axi-dma
+          - starfive,jh7110-axi-dma
+          - starfive,jh8100-axi-dma
+      - items:
+          - const: altr,agilex5-axi-dma
+          - const: snps,axi-dma-1.01a
 
   reg:
     minItems: 1
-- 
2.43.7


