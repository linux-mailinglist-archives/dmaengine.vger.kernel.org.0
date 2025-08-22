Return-Path: <dmaengine+bounces-6160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF0B32493
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7821CE7EC6
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503835209A;
	Fri, 22 Aug 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiSnncrb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC735208D
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898016; cv=none; b=Qxlhgi8HmHCInhDRnST7IdLpmd5PejQLfqsBY2GP4YP3OE+gpZu1Hma25YZuOlXTvxB13kaH0mlsmE105+7eq0qFW2FHUfh65VjT43le8m1Tw7QhuLwQavMxtRk8xPjjOL9M1dV4CGjaw9yxUWOdTbwHD9C93QyxInKwsxYc0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898016; c=relaxed/simple;
	bh=eC1A6NkOSOpLHw7BmMrdgE+pyNgtUry9BNmdqlZgQL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n70N+NZg9Jcri8FJPMkkEGCqO1rjRycjSe9f7YcM4IC+mGiRtnAk1YNGn6rRfyp0IhrDgZ/+46ikHSnlb+ZxyJXkIOryG1IlNCzP0JmjrWTGRtK37tMJCbylGN+5i2NhSTTcyYy+4wQBGou128YxWuxEtc2L6STfS4HLpcx5mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiSnncrb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso32680695ad.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898014; x=1756502814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=38ornbn3jxDRGC0TBG5oYiu+bNjuHezhBgQyOoDyC+Y=;
        b=RiSnncrbEpJBk/LEDS5hYTfzcJpr7AhD0iH8iVKExUvTzqUphAxMHFdr+ub03ZhY59
         LmWN37e7VFBbgtz9JWEuhrUUkNXWPaySVUA1IyTEVx3opAWZpy0vTGXgkBQ2vpv1W1yv
         rmFycYIs67so83rPQF+lPVZQvosEp2O+rODY485jKhtXMuZkXherkWyIZL8qxwH7xz3V
         4zzGFgpYSX3arz4Kcx4uo7wrW43+gxmBSkj+16TzJeXgiTBDVi4NzaNr7bCs0/9++O8N
         dWFh7Ji+udPTHhQi+3HtO/4akBTPkGaAB2IS5NG9l6RgxYaBoYEmEqkw89Q/7xAQ5O7F
         MxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898014; x=1756502814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38ornbn3jxDRGC0TBG5oYiu+bNjuHezhBgQyOoDyC+Y=;
        b=QUbReVKi4ewD2UZ8xFbvxpOu6gpHTl0YarqheXFrkIwOwz2dp3oxg9WQpA7qsTEh+Q
         GdN/CH+WF+pf6mPP6V+HMiHidib66TtDeY4zAjcwHnN00nqGMW3FHVMiIs+ODmvE9nLP
         mHaRy76AVjEpKKKMgH1lNRK9vwKHRB+PNQB01KmksOkhrps/Im6ntCNmk1g+rqwz9eRk
         R5NxvAgywtKFsNZKuSI10Fmjf0ZZ8SnxBhPbouPirFqqZqZy4zAxDyGxRrPT6bYagtZV
         Ax/uyarqeTtSU91s5yl+L+faSdO4E6FExsk1YKqihi01DguKc9SWms3M3NdH/w8eGbwb
         yJTg==
X-Forwarded-Encrypted: i=1; AJvYcCWQXXaU9YQf3Jw8Kd85FZxNUJmZv7zbebfHO+YSMLcSEX04NF8b6ytkx02H+d0u1frH6QZOZw7KSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0XhB1dM2Ibp3IvZQyEcJTOM81uPu6GvZlsB3gDHX0C4U3fQu
	uw85kX5Xt5WnB6Z/YeJd/8JP59eo3HuVLFuoDLvypCVEBsZnz5cBNYueN9SQboAHduDnoMiEAGu
	YPXC419KRbIvXgQ==
X-Google-Smtp-Source: AGHT+IGEhVH4DT4YDDvOB5Y0P9w1lXXR67RVbV4Im5UbeUAIXfdfV8gpSOY1MpxXR8gZ2Y8jo3h5afn4e0nJrg==
X-Received: from pjbpd12.prod.google.com ([2002:a17:90b:1dcc:b0:321:c3e4:5824])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:246:b0:234:9656:7db9 with SMTP id d9443c01a7336-2462ef1f38emr46894415ad.32.1755898013804;
 Fri, 22 Aug 2025 14:26:53 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:17 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-31-dmatlack@google.com>
Subject: [PATCH v2 30/30] vfio: selftests: Add a script to help with running
 VFIO selftests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Introduce run.sh, a script to help with running VFIO selftests. The
script is intended to be used for both humans manually running VFIO
selftests, and to incorporate into test automation where VFIO selftests
may run alongside other tests. As such the script aims to be hermetic,
returning the system to the state it was before the test started.

The script takes as input the BDF of a device to use and a command to
run (typically the command would be a VFIO selftest). e.g.

  $ ./run.sh -d 0000:6a:01.0 ./vfio_pci_device_test

 or

  $ ./run.sh -d 0000:6a:01.0 -- ./vfio_pci_device_test

The script then handles unbinding device 0000:6a:01.0 from its current
driver, binding it to vfio-pci, running the test, unbinding from
vfio-pci, and binding back to the original driver.

When run.sh runs the provided test, it does so by appending the BDF as
the last parameter. For example:

  $ ./run.sh -d 0000:6a:01.0 -- echo hello

Results in the following being printed to stdout:

  hello 0000:6a:01.0

The script also supports a mode where it can break out into a shell so
that multiple tests can be run manually.

  $ ./run.sh -d 0000:6a:01.0 -s
  $ echo $VFIO_SELFTESTS_BDF
  $ ./vfio_pci_device_test
  $ exit

Choosing which device to use is up to the user.

In the future this script should be extensible to tests that want to use
multiple devices. The script can support accepting -d BDF multiple times
and parse them into an array, setup all the devices, pass the list of
BDFs to the test, and then cleanup all the devices.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile |   1 +
 tools/testing/selftests/vfio/run.sh   | 109 ++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/run.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ee09c027ade5..324ba0175a33 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_PROGS_EXTENDED := run.sh
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/run.sh
new file mode 100755
index 000000000000..0476b6d7adc3
--- /dev/null
+++ b/tools/testing/selftests/vfio/run.sh
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Global variables initialized in main() and then used during cleanup() when
+# the script exits.
+declare DEVICE_BDF
+declare NEW_DRIVER
+declare OLD_DRIVER
+declare OLD_NUMVFS
+declare DRIVER_OVERRIDE
+
+function write_to() {
+	# Unfortunately set -x does not show redirects so use echo to manually
+	# tell the user what commands are being run.
+	echo "+ echo \"${2}\" > ${1}"
+	echo "${2}" > ${1}
+}
+
+function bind() {
+	write_to /sys/bus/pci/drivers/${2}/bind ${1}
+}
+
+function unbind() {
+	write_to /sys/bus/pci/drivers/${2}/unbind ${1}
+}
+
+function set_sriov_numvfs() {
+	write_to /sys/bus/pci/devices/${1}/sriov_numvfs ${2}
+}
+
+function set_driver_override() {
+	write_to /sys/bus/pci/devices/${1}/driver_override ${2}
+}
+
+function clear_driver_override() {
+	set_driver_override ${1} ""
+}
+
+function cleanup() {
+	if [ "${NEW_DRIVER}"      ]; then unbind ${DEVICE_BDF} ${NEW_DRIVER} ; fi
+	if [ "${DRIVER_OVERRIDE}" ]; then clear_driver_override ${DEVICE_BDF} ; fi
+	if [ "${OLD_DRIVER}"      ]; then bind ${DEVICE_BDF} ${OLD_DRIVER} ; fi
+	if [ "${OLD_NUMVFS}"      ]; then set_sriov_numvfs ${DEVICE_BDF} ${OLD_NUMVFS} ; fi
+}
+
+function usage() {
+	echo "usage: $0 [-d segment:bus:device.function] [-s] [-h] [cmd ...]" >&2
+	echo >&2
+	echo "  -d: The BDF of the device to use for the test (required)" >&2
+	echo "  -h: Show this help message" >&2
+	echo "  -s: Drop into a shell rather than running a command" >&2
+	echo >&2
+	echo "   cmd: The command to run and arguments to pass to it." >&2
+	echo "        Required when not using -s. The SBDF will be " >&2
+	echo "        appended to the argument list." >&2
+	exit 1
+}
+
+function main() {
+	local shell
+
+	while getopts "d:hs" opt; do
+		case $opt in
+			d) DEVICE_BDF="$OPTARG" ;;
+			s) shell=true ;;
+			*) usage ;;
+		esac
+	done
+
+	# Shift past all optional arguments.
+	shift $((OPTIND - 1))
+
+	# Check that the user passed in the command to run.
+	[ ! "${shell}" ] && [ $# = 0 ] && usage
+
+	# Check that the user passed in a BDF.
+	[ "${DEVICE_BDF}" ] || usage
+
+	trap cleanup EXIT
+	set -e
+
+	test -d /sys/bus/pci/devices/${DEVICE_BDF}
+
+	if [ -f /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs ]; then
+		OLD_NUMVFS=$(cat /sys/bus/pci/devices/${DEVICE_BDF}/sriov_numvfs)
+		set_sriov_numvfs ${DEVICE_BDF} 0
+	fi
+
+	if [ -L /sys/bus/pci/devices/${DEVICE_BDF}/driver ]; then
+		OLD_DRIVER=$(basename $(readlink -m /sys/bus/pci/devices/${DEVICE_BDF}/driver))
+		unbind ${DEVICE_BDF} ${OLD_DRIVER}
+	fi
+
+	set_driver_override ${DEVICE_BDF} vfio-pci
+	DRIVER_OVERRIDE=true
+
+	bind ${DEVICE_BDF} vfio-pci
+	NEW_DRIVER=vfio-pci
+
+	echo
+	if [ "${shell}" ]; then
+		echo "Dropping into ${SHELL} with VFIO_SELFTESTS_BDF=${DEVICE_BDF}"
+		VFIO_SELFTESTS_BDF=${DEVICE_BDF} ${SHELL}
+	else
+		"$@" ${DEVICE_BDF}
+	fi
+	echo
+}
+
+main "$@"
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


