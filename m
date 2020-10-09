Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCF2890B0
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbgJISXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 14:23:04 -0400
Received: from mail.csu.ru ([195.54.14.68]:37389 "HELO mail.csu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731198AbgJISXE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Oct 2020 14:23:04 -0400
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 14:22:54 EDT
Received: from webmail.csu.ru (webmail.csu.ru [195.54.14.80])
        (Authenticated sender: gmu)
        by mail.csu.ru (Postfix) with ESMTPA id 9EA00146ADD;
        Fri,  9 Oct 2020 23:12:05 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.csu.ru 9EA00146ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=csu.ru; s=lso;
        t=1602267137; bh=EHyoM7tvrYOQrxF04FX0pRVRvphefdiNsT3iXJDpiBo=;
        h=Date:Subject:From:Reply-To:From;
        b=JgmKnEwUa2H4guTvvGXcm+G0tbE8hRVj91/tN+idLHyOF4wk0A535Uc522g7yzONB
         11lBhJi20Vs8vlWrJJV7umqCG8m0/gP1SytymOM2p1mcuAg1yXTqpi9wyLu/L2WMA4
         Yf/FY5XfgqaHX1mVolq5iOGoKO0tcHkLI3aRlaVQ=
Received: from 156.146.59.22
        (SquirrelMail authenticated user gmu)
        by webmail.csu.ru with HTTP;
        Fri, 9 Oct 2020 23:12:08 +0500
Message-ID: <3714bded3cc624bd8ed00fd6a579589c.squirrel@webmail.csu.ru>
Date:   Fri, 9 Oct 2020 23:12:08 +0500
Subject: Vorschlag
From:   "Yi Huiman" <info@csu.ru>
Reply-To: info@huiman.cf
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3 (Normal)
Importance: Normal
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 159051 [Oct 09 2020]
X-KLMS-AntiSpam-Version: 5.9.11.0
X-KLMS-AntiSpam-Envelope-From: info@csu.ru
X-KLMS-AntiSpam-Auth: dmarc=none header.from=csu.ru;spf=softfail smtp.mailfrom=csu.ru;dkim=none
X-KLMS-AntiSpam-Rate: 70
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 381 381 faef97d3f9d8f5dd6a9feadc50ba5b34b9486c58, {rep_avail}, {Tracking_content_type, plain}, {Prob_reply_not_match_from}, {Prob_to_header_missing}, {Prob_Reply_to_without_To}, {Tracking_susp_macro_from_formal}, csu.ru:7.1.1;huiman.cf:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;webmail.csu.ru:7.1.1;127.0.0.199:7.1.2;195.54.14.80:7.1.2, ApMailHostAddress: 195.54.14.80
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2020/10/09 16:54:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2020/10/09 00:29:00 #15463494
X-KLMS-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ich habe ein Gesch=E4ft Vorschlag f=FCr dich.

