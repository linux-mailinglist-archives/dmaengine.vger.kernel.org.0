Return-Path: <dmaengine+bounces-7765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5ECC872E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47382303C01B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90734D39F;
	Wed, 17 Dec 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kewwEJUP"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362434C81B;
	Wed, 17 Dec 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984599; cv=fail; b=br2mxB5WHRH89BifTgdQumwXn07NGNPeqNkSK8DIiGT32Rrra0Iwgx3M5Qov84W3+hjvPzRyKpRwtthivrq4BpF9NgoJpTayAF8inDKabgNmuU79XPX/ueyQYDULlTx8qYVZC4dWNQSwZvm4NNeKUUYMltlubWP65ZqSbrmfpSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984599; c=relaxed/simple;
	bh=X1gyC75kPkBreSQ/PuHtjCb2BLVgrEyeeKKGwnkUegw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCK+dDrjqzdbW4swF/MurYaCmzVGjvqM9DPWrkHVE31b6iEAKI4R3DVZ63GkJdbdp2y6W4O0ZHHT9enXcT9WEopNiRTlugZW471P5C+3IAXqOOiReeSrPfLBSaq+WWAuJJ4RWV9CX7A3fz9WPbXLP+hlUWcYN2TcNSCNqyLRj44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kewwEJUP; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdj5zkD6ZeInJJVOVo7kdyDGSiQLQACeQheChK0u9EaBfcLGID5WNph+0IYYzu4EWZ7Dg2by5GVDGaKIDegZuiq4Q/gLX0CFslS6b9JkFY+f7CJDdwyAA7bbVJBNTunSCzBnpnxxGcqL//CVRLDrngmPcrvlpiqAtNMjY2PmuAaxWIbocawnyWd42fv4yOxI/luxJYzvgh6Xgq/iJTk9nYiHudqfMKQq4713XkoSWwmHXTUSX0C0Mfbqh4uyAdJCkCIZ8K+dsMn1LWgjbrJ1NxYCagInr4jXKTwQwRVzXj0IxUwRIDBBRTmY97wyU0wm/qvVyqw98rfwf7njd7jJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTckdEK71i2FZ/shAyWfB9nnUIpC5pJr+kX4XYeqjzc=;
 b=YPbYnRDgVtOqDkzPddJoEq7kWIHUx13UvHfPI/UpzLEEB6CYGuOon9wSgEPopEX7OhbwaQM6FtBKF4g6w0dxPA02b11vspxFKgjtG8tItFKYfwRIS56cV+QtXtp62egz+21cs0UkiYTYZ61l3I4+ZfuuFO/ZLcHQDuxiRlfqcZ13Yyhzy24kRd2MWFzI9bAMZxpV+PiJY2s7Ev9v/9G1yWYLk1qXsVR+g7kxVerdnyG25KL0Ri2Nv9gDQ1DsddbWYJjHnpqDj5o9SH1wLSJsT8+yQdfdnGam+HyQ2WPvT0yCAOSAp7AoLfy/huAcvlUB0o7unDfz/5bf7dcdLb/bjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTckdEK71i2FZ/shAyWfB9nnUIpC5pJr+kX4XYeqjzc=;
 b=kewwEJUP3Kfr2kJvoP/ZLbSrP+8q4mfaDUGVOhzoDXyzydnHWIbDtU/1A8tdFxjfp2b+sYa1tMJDiW/bcUQU6nVaKfQN7qYGAqzY5ySncvleR7+KPtkMJsHsEjzs9nQZLzWQBDd1x7MQQ/KKqajHAWj+zo+nNTHdylyeeo37EaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:21 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 09/35] NTB: epf: vntb: Implement .get_private_data() callback
Date: Thu, 18 Dec 2025 00:15:43 +0900
Message-ID: <20251217151609.3162665-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: e5505afe-8728-4fa5-b010-08de3d7f3c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b/J+3KHcygfi/mxJZgCctv39ukBPH6cbySCvpNGfuD/7y26g2TSOtysq3c2z?=
 =?us-ascii?Q?DpctGfjyk/Ic6v+Macs0mBKMPWMForl68D8C7b8PRbbcryk22tgsQCpLZRYO?=
 =?us-ascii?Q?0B8mVMaiDGH/YMCZ2DfNqR5+revlngBNukGf+4UOrcC6sdkxoTJCvguzJ7XY?=
 =?us-ascii?Q?ZwpbMzsIRPhaN8pSlIG/3wt4hMbfpPyyc2RACZFO9/cw7wFsuBaOY2uQ9gzQ?=
 =?us-ascii?Q?z3/ImPM/d7NQ4N4RCUwIiYj8i+aSJPjif+oVVncu2BRxbSuCyPC1U+Q+72wy?=
 =?us-ascii?Q?gR5TIpUge4o0vU8fjXDf+1KQtc2NPBWt7OPip4Oyxh3+yX6V5GTxadC7qSMk?=
 =?us-ascii?Q?T+8KKExWmql9P2ZqAiDfXkdAuWa9j+Qk9awI2y0o0niUJDlR2fo1jnFNVyAi?=
 =?us-ascii?Q?fgCBgEWfzLQ5SU2cyDaWFJubj/jAMujeeLkjpFIn8cukO9KEyjSgGFRqLFcT?=
 =?us-ascii?Q?MiAky79DD2BFBqYLuCLT9NAS7sEJKYtAiV26NHEiIviwoa3lb30z67eVDWkf?=
 =?us-ascii?Q?R8zA44Ys9vXUujpsXrKkTs8XfrdAN711q3FBdXfuEhtHNoPcZQS7ykhqPbR3?=
 =?us-ascii?Q?CV2HB9+VFSLJHLGI0ck9vn2pDXNDZwvvAdJG7kxJgOfT1ciMMQnNKrtUymVo?=
 =?us-ascii?Q?jQYL2I/YAEa4zHzRwHKiktBXiOIVj88SfQZVNd8LbbqYM7pp9S7TRszffwd/?=
 =?us-ascii?Q?xHV9Cz8fWuDON4j246aFrqH3APgvUApleaCuVeE6BhxQJhmjW6Upef1taaCz?=
 =?us-ascii?Q?nyQwlQ9I2KezoSUOir1jh/Kspql6k9cF0sBCKDpOu86LaxHxV/S2kCXmfb2r?=
 =?us-ascii?Q?6B2m7/QfygKn0gnWtQa8/p5VQRnUaeFQJHgCAY1JrCT+J87A0IGBn1fx25dT?=
 =?us-ascii?Q?ZfKXDEavpLySSIo+4itNBstbPwdhVjbvzErRP6bhGuC1I2WgXS5TYkBOoirj?=
 =?us-ascii?Q?rfylCLLhjLMIqb2bmHB5VKyAgk0le/nsN9N/GBhbh2b842vIJGR5UTE/UBlN?=
 =?us-ascii?Q?fFnckkFdOt4tf3JK2PPZcHLKWteLpj3BNT9VMPWyJcnEi8sEa3vhUhU9/3+0?=
 =?us-ascii?Q?QyZSi6uqaL3BjrpyVGXHUerd/x0CbK4hC9cwgN+ZNhP2b05S0zYyXzITIsZ1?=
 =?us-ascii?Q?V5XY6h2TqL9+DvOX2q3bcftQGsD57iJmlWlLB3sn/xn5BoT1pf4YePET2v6K?=
 =?us-ascii?Q?iiOC+NWyI5JVfv2E+ZYhxs21Uw2QO3R/D9A+Cak1Cw6wxpIZI+nF9DuEkVYJ?=
 =?us-ascii?Q?/HuhRvwMbs1yZyNjpt7J/mysMWsJieS6H9x8Hr2tMGkdWRQzguY9imX40ytX?=
 =?us-ascii?Q?k/d6/YD3oxF8Gdjz93kIn9Y3fnzBu696gYzfSw89Q+uu3LQ6gq8jyrLcsJl7?=
 =?us-ascii?Q?I8dywaNmtYzQGmkXG8OXlRRv0+cyqcxRVtI3AxsQvfj0EtZYm6sbQ3d37SzF?=
 =?us-ascii?Q?wxSBuOH4NPjdLMxgBSJqcu1oVP+5Z1YK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dKW1Sb+gyUZ6NKPByFfdRyDh5moWczZvxKKq9IO5/uMUfRHog9KSqUU8saO4?=
 =?us-ascii?Q?KiYa8Uhj1PUB0A/9ZwpcqNR5iE0j1HTbShsjRMBjvusUjs23s9JEpxyQtE53?=
 =?us-ascii?Q?wer6ABIr4duVbt7BMtfE7REu8e8h5XkXhyXFCZKuKG6G8oJBi6YMiYUPrujz?=
 =?us-ascii?Q?hzYKZhpv5k5wtabgi0eqjiFDsQOiKt7kI0mj1VWfJz7Eb0YtOHhrfVAHmMiY?=
 =?us-ascii?Q?61Ne8+xosP4Cl3OsBKjN9gsQlmz1axarHWuWqhSmcPZbGwPbiCd/YO60yzqY?=
 =?us-ascii?Q?TLRZHqfcv6AzSxX8C26xCnYDGLI4amEKFpYL3hR6vZHdQApQVnr2nsNswgV6?=
 =?us-ascii?Q?AO1MC2VSKWn/+dn1pfa1VqWrY2saHIjROPH2beu08iBn837wbzAdR+ZAP+EZ?=
 =?us-ascii?Q?XrJWa5pWyesIqJm/zpMm0xwwv5uELFWjYcZK8b97IPtGn90ILJ72ZiQCxlFY?=
 =?us-ascii?Q?/IYFDIOa8QgUSowXeOeNse/ZS9ydZcNEi65J0+81C4FECevdeZAhW86n7mo+?=
 =?us-ascii?Q?3CuxbS6AJazlDTufYjvz7Ps9zE0s4Ed3mjg5pMiLAs9HYwiCEC1zj80a4QRc?=
 =?us-ascii?Q?jRWPHNfhBa6XhhJOQ4rcFZl09jCmaAVhmTl5PQzThSu+Yo4YCoeUyPSRh0hU?=
 =?us-ascii?Q?dFe9HaXLCr90zSHZXiv+zySEfPXTQZP+9tyIceT6Ve+4uLrHcOLBGLnflF5k?=
 =?us-ascii?Q?XoZLmE74XjOPCPechAwA3TK23BVFDQqYk16AZA7KIPQQkgv4XwmmrbjK6Mst?=
 =?us-ascii?Q?tP+wgdL41vW9EbHO3Hl5HY1LLdLTBXknewzLBCl7Zhc2EGAccctZ90TzhI2U?=
 =?us-ascii?Q?PEq0nbwZP4oYId0Di/xvC2MMsG/XB2PxTTEBQjb2aoCeyh65XjBY/tGA2uG7?=
 =?us-ascii?Q?/WhOqvT9rxyXgL9kpWi4YjV4f0ydFAkvVellkmIAx2tIBxwVo8BG36ysNa21?=
 =?us-ascii?Q?Ui/t+cR8DxEl9hxLjpPCcV70SqNfWvplwghph/PiSqvWbBvwIfl1mCky+I+z?=
 =?us-ascii?Q?5E/B5YEn8woPqrfqFsbEylVjqZHMzONEaY2SSdTb/t73/S2EkQ+46kZRcRXI?=
 =?us-ascii?Q?1e4JD7ETv3TZkFN3xakHHv7B0C+H4OJhVwyawnqov7QiRYrEnP74cTqwwLCn?=
 =?us-ascii?Q?XKF2bm9WxudUBVBkErVeHbJdZrYuBgQWed6w0WY2yx+4i5DrxiUPk6B/MjQG?=
 =?us-ascii?Q?dhkBBzYyqDOf8eGKTX3jE0/x5YeW9783Zahw7T+e475CyZ4fWTuaKu5Robho?=
 =?us-ascii?Q?zuLgQVofVyYT33ZsEqA7QNgOFRk4EAfzmkp/hoJBypetY5WXeN1PFYmALYRD?=
 =?us-ascii?Q?VdDEU/rAH/Vcko+03SWabmziKpbv6TjPuISIpy8oIHEA4iKzZN7kv/BpuYcP?=
 =?us-ascii?Q?23ZbSfOP1CL/6cJejwhQ++C5Ib8gKSXadeekbQmdjzuQUJRiCw8wN6FJnYmL?=
 =?us-ascii?Q?x/Ta18fYbmSiyddLR83mgo9sceMjOKp0Z4Vn4BEzYcVbaOYPdN+IdOKW7tjV?=
 =?us-ascii?Q?DGZNC+H7vet4wIDfP0Vmrs5IbYCj7pyvk7vZX8OTdbko82Rcu5TgxinssCb8?=
 =?us-ascii?Q?llwj/jxkJaQHX8Nychg66JLb1Y3w+/KPgCkR5GjjpCY/RpcRffDPiufFxgLi?=
 =?us-ascii?Q?FAshQXZp/Gkd3bf0uKXXV6U=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e5505afe-8728-4fa5-b010-08de3d7f3c21
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:21.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNEOS07uJQ0TVObqdoWxQKfgwHkPVi02EE3e69MW0KOymrCgBEH9PvFtaHtoILzPnKFbLX9Qsk+9Hex7oiNyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Implement the new get_private_data() operation for the EPF vNTB driver
to expose its associated EPC device to NTB subsystems.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 23bbcfd20c3b..c89f5b0775fa 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1582,6 +1582,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static void *vntb_epf_get_private_data(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	if (!ndev || !ndev->epf)
+		return NULL;
+	return (void *)ndev->epf->epc;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
 	.mw_count		= vntb_epf_mw_count,
 	.spad_count		= vntb_epf_spad_count,
@@ -1603,6 +1612,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_private_data	= vntb_epf_get_private_data,
 };
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.51.0


